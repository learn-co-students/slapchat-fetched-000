

# SlapChat Fetched (Results Controller)


So far, we've been implementing `viewDidAppear` to handle refreshing our data, but the process (fetch, pass, reload) could be a little overkill. Also, what happens if we can't rely on `viewDidAppear` being called? Fortunately, there's a more sophisticated solution for refreshing our [core]data called `NSFetchedResultsController`. 

To be vague, the controller intelligently feeds data to a tableView, only updating it when there are changes. To be more specific, it fires off delegate methods when the results of it's fetch change. Like most other Core Data things, there's a buncha boilerplate for implementing these delegate methods (which we provide). If you want to read more about how it works, check out the [Apple docs](https://developer.apple.com/library/ios/documentation/CoreData/Reference/NSFetchedResultsController_Class/).

##Instructions
Let's integrate `NSFetchedResultsController` into good ol' slapChat.

###Add Messages Button
Set it up so we can add new messages to our tableView without going to a different view controller, creating a situation where we can't rely on `viewDidAppear` for refreshing.

1. Add a plus button to your navigation bar.
2. When the plus button is tapped, have it create a new `FISMessage`.   
   - For now, just set it's `content` to a string version of the current time.
   - Don't forget to save it! 
3. Test it: run your app, hit the add button once, then run again to see if your message was added properly.
4. Trash your implementation of `viewDidAppear`; we won't be needing it anymore :D

###Implementing Results Controller
We're going to set up the results controller within our tableView controller for a few reasons. First, you can only set the NSFRC's delegate (which you need) **once**. Second, Apple warns against changing NSFRC's fetch request or predicates post-initialization, so we want to set them up per view controller. Last but not least, we want our view controllers to be as self-contained as possible.

1. Add an `NSFetchedResultsController` property to your tableView controller.
2. In `viewDidLoad`, initialize it using `initWithFetchRequest:managedObjectContext:sectionNameKeyPath:cacheName:`
   - Be sure to **add a predicate to your fetch request** before you use it to initialize NSFRC; your app will crash otherwise! 
   - you can enter `nil` for both `sectionNameKeyPath:` and `cacheName:`
3. Set your tableView controller as the NSFRC's delegate. Don't forget to conform to the appropriate protocol :)
4. Scroll down in the `.m` and check out the boilerplate `NSFetchedResultsControllerDelegate` implementation we included.
Read through the methods to see how they will handle changes. Also **uncomment them.**
5. NSFRC has a `fetchedResults` property (*a prime example of good naming conventions!*). Remove your local messages array *entirely* and replace it in the data source with your NSFRC's array.
6. Finally, call `performFetch:` on your NSFRC at the end of `viewDidLoad`. 
   - Enter `nil` for the argument, we'll get to how `NSError`'s work later on.
7. Run it, and be amazed as you tap the add button and messages magically show up in your tableView! 
<a href='https://learn.co/lessons/slapchat-fetched' data-visibility='hidden'>View this lesson on Learn.co</a>
