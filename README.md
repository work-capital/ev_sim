# EvSim


A flexible way to implement Process Managers seems to be fine for us, but we need to build a POC to see how it looks like in real life. The  https://github.com/work-capital/ev_sim can be an illustration of what we mean. The starting point is to have a complete and common environment for specifying, testing and simulating (also answering @Papipo comment n. 3) the whole system (instead of unit testing). Dealing with unit testing for aggregates is okay, but the "I/O Protocol"  should be uniform to be piped into the whole system, and the whole system should behave as a pure function. For example, in a system with a Trade, Inventory, and Payment aggregates, and a Process Manager to handle the Purchase Process, we need to input one command to buy an Item in Aggregate that will trigger the Inventory, that will back to the Process Manager and wait for the Payment command, that will finish the Process Cycle. 

Test Case Business Simulation Cycle: 

```
commands   = [%BuyBook{}, PayBook{}]

aggregates = [%Trade{}, %Inventory{}, %Payment{}]
process_m  = PurchaseProcessManager
system     = aggregates . process_m
events     = [%BookBought{}, %PaymentAccepted{}]

assert commands -> system -> events
```

As you see, two commands were sequencially injected into the whole system, and we asserted that in with this commands, the system as whole reacted and produced out these two events. Imangine that with 5 or more aggregates, and 2 process managers, how easy will be for our team to receive the business requirements and transform into a complete pure functional system, even before writing anything on the database. In a few words, we write the pure aggregates and process managers (with or without FSMs), package them together, and test I/O behavior in several scenarios. 


Let me list some libraries that could help us to finish this task. Maybe we should get some ideas from them, and build a pure test/simulator framework to encapsulate  CQRS/ES components.


[effects](https://hex.pm/packages/effects) - Very interesting 
[monadex](https://hex.pm/packages/monadex) - Operators could be more elegant,
but very complete 
[plumber_girl](https://hex.pm/packages/plumber_girl) - Railway oriented 
[towel](https://github.com/knrz/towel) - Pragmatic Elixir stilysh {:ok, _}

For that it's crucial that we agree on how inputs and outputs will be piped and
handled in an uniform way, avoiding anbigous responses, sometimes the event,
sometimes the {:error, :reason}. Let me suggest to use the Monad
[Writer](https://hexdocs.pm/monadex/Monad.Writer.html#content), so we keep
processing, changing the state, and logging the output. The final output, as the
assertion above, should be the *logged* events accumulated in the Writer Monad.

Using execution(state, command) will also help to make the aggregate easier to
test, and should be part of the protocol. Please, let me know your thoughts.


### Some links on Process Managers:
http://blog.devarchive.net/2015/11/saga-vs-process-manager.html 
http://codebetter.com/gregyoung/2012/04/24/state-machines-and-business-users-2/ 
http://www.enterpriseintegrationpatterns.com/patterns/messaging/ProcessManager.html 




###CQRS Links: 
https://github.com/MicrosoftArchive/cqrs-journey 
https://github.com/MicrosoftArchive/cqrs-journey/blob/0ec521933fc0fe2907096decbdc9b110bba4a621/docs/Journey_03_OrdersBC.markdown



Below the Process manager implemented in this example: 



![architecture](https://raw.githubusercontent.com/MicrosoftArchive/cqrs-journey/0ec521933fc0fe2907096decbdc9b110bba4a621/docs/images/Journey_03_Architecture_02.png)
