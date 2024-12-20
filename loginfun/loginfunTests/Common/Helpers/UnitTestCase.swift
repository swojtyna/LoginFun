import Combine
import XCTest

private struct AwaitError: Error {}

open class UnitTestCase: XCTestCase {
    public var cancellables = Set<AnyCancellable>()

    override open func setUp() {
        super.setUp()
        cancellables = []
    }

    override open func tearDown() {
        cancellables = []
        super.tearDown()
    }

    @discardableResult
    public func awaitState<P>(
        from publisher: P,
        timeout: TimeInterval = 0.2,
        file: StaticString = #file,
        line: UInt = #line,
        where predicate: @escaping (P.Output) -> Bool,
        afterAction: (() async throws -> Void)? = nil
    ) async throws -> P.Output where P: Publisher {
        var result: Result<P.Output, P.Failure>?
        let expectation = self.expectation(description: "Awaiting state matching predicate")

        publisher
            .filter(predicate)
            .first()
            .sink(
                receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        result = .failure(error)
                    }
                    expectation.fulfill()
                },
                receiveValue: { value in
                    result = .success(value)
                }
            )
            .store(in: &cancellables)

        try await afterAction?()
        await fulfillment(of: [expectation], timeout: timeout)

        guard let unwrappedResult = result else {
            XCTFail("No state emitted matching predicate", file: file, line: line)
            throw AwaitError()
        }

        switch unwrappedResult {
        case .success(let value):
            return value
        case .failure(let error):
            XCTFail("Publisher completed with error: \(error)", file: file, line: line)
            throw error
        }
    }
}
