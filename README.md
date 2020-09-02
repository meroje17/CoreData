# CoreData

## What's that ?

### Goal

In your iOS application(s), you want to save and keep data for offline use. Core Data is the tool you need ! Here I will try to teach you the core data basics with this "To do list" application.

### How works ?

<p float="left">
  <p align="middle">
  <img src="https://zupimages.net/up/20/36/j4x0.png" data-canonical-src="https://zupimages.net/up/20/36/j4x0.png" width="600" height="300" />
  </p>
</p>

Core Data Stack contains :

* **NSManagedObjectModel** : representation of your application data model, file describing entities and relationships between us.

* **NSManagedObjectContext** : tracks changements and tool which allow you to CRUD (create, read, update, delete).

* **NSPersistentStoreCoordinator** : saves and fetches all entities in your application.

* **NSPersistentContainer** : sets up model, context et store coordinator. 


To understand you can ***Follow next chapter "Steps"*** or ***fork my project and run ToDoList*** to see all the code **WITH tests**.

## Steps

## 1 - First of all, you need to create a data model :

<p float="left">
  <p align="middle">
  <img src="https://zupimages.net/up/20/36/g7g8.png" data-canonical-src="https://zupimages.net/up/20/36/g7g8.png" width="172" height="280" />
    &emsp;
  <img src="https://zupimages.net/up/20/36/nd0z.png" data-canonical-src="https://zupimages.net/up/20/36/nd0z.png" width="600" height="280" /> 
  </p>
</p>

## 2 - After this, fill your data model with creation of entity|entities and theirs attributes.

<p float="left">
  <p align="middle">
  <img src="https://zupimages.net/up/20/36/na05.jpg" data-canonical-src="https://zupimages.net/up/20/36/na05.jpg" width="500" height="400" /> 
  </p>
</p>

## 3 - Create CoreDataStack.swift file :

<img src="https://zupimages.net/up/20/36/30k8.png" data-canonical-src="https://zupimages.net/up/20/36/30k8.png" width="450" height="450" />

* Line 10 : Import CoreData to use it.
* Line 16 : Initilization the reference of persistent container.
* Line 26 : Retrieve context with container.
* Line 34 : Method to save context (changements about entities). 

We don't work with entities in this file, because using inheritance on this class for tests (if you want know how can testing this : please fork the project and observe on it).

## 4 - Create CoreDataManager.swift file :

This file manage core data entities.

<img src="https://zupimages.net/up/20/36/suqz.png" data-canonical-src="https://zupimages.net/up/20/36/suqz.png" width="500" height="350" />

* Line 10 : Import CoreData to use it.
* Line 14 : Creation of variable coreDataStack to use the context and this methods.
* Line 15 : Creation of array of my entity "Task", we fill it with NSFetchRequest (retrieve in core data all entities of type Task).
* Line 25 : Method to create task, init it and save the context.
* Line 31 : Method to reset core data -> Delete all existing tasks in core data and save the context.

For the two methods, I return a boolean to know in controller if saving works else I can display an error.

## Installation

First step:

```bash
Fork the project on your Github to have repo
```

Next step:

```bash
Git clone on your computer/laptop
```

Test or change what you want. And the most important information : LEARN !

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)

### Some links about me:

<a href="mailto:guerinjerome@outlook.fr">Mail</a> |
<a href="https://www.linkedin.com/in/j%C3%A9r%C3%B4me-gu%C3%A8rin-7aa056195/">Linkedin</a> |
<a href="https://github.com/meroje17">Github</a>
