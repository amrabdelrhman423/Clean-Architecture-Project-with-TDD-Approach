# Clean-Architecture-Project-with-TDD-Approach

Small project to implement TDD(Testing Driven Development) by applying  SOLID and YAGNI and rules(Clean Architecture && Clean Code by Robert C. Martin (Uncle Bob))

## Description

![clean](https://github.com/amrabdelrhman423/Clean-Architecture-Project-with-TDD-Approach/blob/master/images/clean3.jpg)
### Architecture Components
Every "feature" of the app, like getting some interesting trivia about a number, will be divided into 3 layers - presentation, domain and data. The app we're building will have only one feature

![clean](https://github.com/amrabdelrhman423/Clean-Architecture-Project-with-TDD-Approach/blob/master/images/clean4.png)
### Presentation
This is the stuff you're used to from "unclean" Flutter architecture. You obviously need widgets to display something on the screen. These widgets then dispatch events to the Bloc and listen for states (or an equivalent if you don't use Bloc for state management)
Note that the "Presentation Logic Holder" (e.g. Bloc) doesn't do much by itself. It delegates all its work to use cases. At most, the presentation layer handles basic input conversion and validation.
### Domain
Domain is the inner layer which shouldn't be susceptible to the whims of changing data sources or porting our app to Angular Dart. It will contain only the core business logic (use cases) and business objects (entities). It should be totally independent of every other layer.
### Use Cases

Use Cases are classes which encapsulate all the business logic of a particular use case of the app (e.g. GetConcreteNumberTrivia or GetRandomNumberTrivia).

###### "We should think about our application as a group of use cases that describe the intent of the applications and group of plugins that give those use cases access to outside world. (Uncle Bob)"
### Dependency inversion
Dependency inversion principle is the last of the SOLID principles. It basically states that the boundaries between layers should be handled with interfaces (abstract classes in Dart).
### Data layer
 The data layer consists of a Repository implementation (the contract comes from the domain layer) and data sources - one is usually for getting remote (API) data and the other for caching that data. Repository is where you decide if you return fresh or cached data, when to cache it and so on.

![clean](https://github.com/amrabdelrhman423/Clean-Architecture-Project-with-TDD-Approach/blob/master/images/clean.png)


## Usage

TDD Cycle is also known as the RED-GREEN-REFACTOR CYCLE: is when a developer writes a failing automated test case, then produces the simplest code needed to pass that test, refactors the code until it meets acceptable standards.


![clean](https://github.com/amrabdelrhman423/Clean-Architecture-Project-with-TDD-Approach/blob/master/images/tdd.png)

#### Steps used in TDD:
1-Add a test

2-Write the code

3-Refactor code



## references
[Bob Martin – The Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)

[CodingWithMitch – 2 Key Concepts of Clean Architecture](https://www.youtube.com/watch?v=NyJLw3sc17M)

[Testing Driven Development](https://runtimerec.com/blog/post-2/)

[Ian Cooper, The Clean Architecture](https://www.youtube.com/watch?v=SxJPQ5qXisw)

