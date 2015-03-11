import Foundation

// Background syntax sugar
infix operator ~> {}

// Queue for dispatch serial operator
private let queue = dispatch_queue_create("serial-worker", DISPATCH_QUEUE_SERIAL)

// ( background ) ~> ( main thread callback )
func ~> <R> (
    backgroundClosure: () -> R,
    mainClosure: (result: R) -> ())
{
    dispatch_async(queue) {
        let result = backgroundClosure()
        dispatch_async(dispatch_get_main_queue(), {
            mainClosure(result: result)
        })
    }
}