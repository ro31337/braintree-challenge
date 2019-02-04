# Basic Credit Card Processing

Software for credit card provider. Adds cards accounts, processes charges and credits against them, shows summary
information.

# Usage

From console:

```
$ ./app.rb input.txt
```

or

```
$ ./app.rb < input.txt
```

# Tests

To run tests:

```
$ bundle
$ rspec
```

# Design decisions

There are few interfaces:

* Card - represents the card with limit and balance.
* Command - represents different types of commands that can be performed on card: add, change, credit.
* Parser - processes input and produces commands.
* Repository - central unit that accepts commands and dispatches them to cards.
* Input - file or stdin input

And decorators:

* Valid card - decorator around Card. Doesn't allow to charge, credit, or get value of invalid cards.
* Sorted repository - produces sorted repository results.

# Why Ruby

* Ideal for tiny commercial projects, allows faster development with object-oriented approach.
* Since no information was given, assumption was made that performance is not critical. 

# Author

[Roman Pushkin](mailto:roman.pushkin@gmail.com)
