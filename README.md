# Basic Credit Card Processing

Software for credit card provider. Adds cards accounts, processes charges and credits against them, shows summary
information.

# Usage

From console:

```
$ ./app.rb sample.txt
```

or

```
$ ./app.rb < sample.txt
```

`sample.txt` is included.

# Run with Docker

If you have issues running the app or want to run it isolated, you can run it with Docker:

#### Update sample

Update `sample.txt` to your input

#### Execute

Execute:

```
$ docker build -t roman_pushkin_braintree .
$ docker run -it --name roman_pushkin_braintree roman_pushkin_braintree
```

#### Cleanup

```
docker rm roman_pushkin_braintree
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
