# Casting SPELs in LFE?

The decision to port Casting SPELs in Lisp to LFE was based on two things. Firstly, it was inspired by an interest in providing the community and new comers with a greater number of interesting learning tools for the language. Secondly, whimsy. The original for Common Lisp was such great fun; how delightful to share that with the LFE community?

It's actually very easy to port basic Common Lisp to LFE. But once you get deeper than syntax, things can diverge quite strongly. It turns out that the immutable data of Erlang and LFE made porting this comic book quite tricky. In the end, I had to give up all hope of the whimsy, and switch gears to basic application architecture best practices.

As such, you will see a *very* different comic in this book than in the others: immutable data, Erlang records for tracking game state, state being returned by most functions, and many more. At first I was disappointed: this wasn't going to be the best casual, entry-level introduction to LFE.

Upon further reflection, however, I came to embrace this difference. Erlang, and thus LFE, is not just another language you can pick up in a weekend and hack on for fun. It's not a Python, or Ruby, or Julia. Erlang wasn't created to solve the human problem of making a better high-level language, of making programming fit in the brains of new developers more easily. Rather, Erlang was created to hammer a very different nail, and quite the sledgehammer it turned out to be: pounding out some impressive fault-tolerant, distributed systems. Erlang was created to so that programmers could make better *industrial grade telecommunications infrastructure*.

That's not a Sunday afternoon hacking project.

And this brings me to the point: LFE is not a casual Lisp. It's a Lisp for those who want to build distributed applications like the Erlang software that powers 40% of the world's telecommunications. As a systems programming language, it's somewhat more involved and has many more moving parts than the sort of languages that are picked up like hobbies or to crunch data at work. It's a complete programming language, but it's also like an operating system; a highly-concurrent distributed operating system. If you've never programmed before, I would highly recommend learning another language first, waiting to tackle the concepts behind distributed systems once you have a strong foundation in place.

So why build a game with it? Well, games can be fun when played alone -- and often are. But they can be even *more* fun when played with good friends. Even lots of friends! By learning to write games in an industrial-strength Lisp which specializes in distributed, fault-tolerant, message-passing applications, you're getting a foundation that can help you build the next SPEL-casting MMOMUD :-) But I digress.

As a result of these ponderings, I concluded the following: the concerns about introducing records, pattern matching, guards, immutable data, and process servers paled in comparison to the other potential ways this comic book could have been rendered for use on the Erlang VM (don't worry, there's no OTP!). And for those who *are* ready to jump into the world of functional programming for distributed systems, this is a *super* fun way to start, giving you an intuition for some of the basic building blocks you will use in every LFE application you build from here on out.

Enjoy!
