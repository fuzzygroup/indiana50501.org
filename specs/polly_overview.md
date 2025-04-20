# Polly Overview

Polly is short for Political Events Manager and it is a piece of open source software that is being developed by Indiana 50501.

It is my thesis that the work we are doing to build Indiana 50501 is **not** unique.  We are doing grass roots political activism that basically boils down to:

* Create an event
* Figure out what has to happen for said event
* Rally people to go out to the event
* Deal with the consequences of said event
* Lather; Rinse Repeat

An event is actually a data structure.  Yes it is actually a thing that happens in the real world but an event has properties like:

* Name
* Location
* Start Time
* End Time
* Speakers
* Musicians
* etc

We are drowning in details from running events and we are failing to leverage the contacts we are generating as a function of the events.  

What we need is a software platform that:

* Guides us thru the process
* Captures data
* Makes us more effective
* Allows us to generate **high touch** interactions with significant individuals (yes I hate that term but there are people in the world who matter and we are interacting with them and losing data during the process unless we explicitly recognize them)

## What Does Polly Do?

Polly is a web database application built using Ruby on Rails as a CRUD app.  Essentially it is a series of data tables and data capture forms which let us:

* Make an event
* Clone an event
* Promote an event
* Capture data from an event
* Make sure that things aren't forgotten
* Capture people saying "Yeah I'll go"
* Help vet people
* Capture volunteers and what they can do

Right now we are honestly limited by human memory i.e. Scott or someone remembering "oh yeah Person Foo can do Task bar".

## Features

* Make an event
* Add an object to an event where object might be  a speech, a musician, etc.
* Add a poll to an event

## Concepts

Here are a few of the core operating concepts that Polly needs to enable.

* **High Touch Interaction** 
* **Farley File**

## Data Model

Please note that this isn't an exact data structure but a rough brain fart designed to facilitate RAPID prototyping.

### Group

A group is a collection of people that run political activities.  Indiana 50501 is a group.

rails g scaffold Group name:string state:string town:string zip_code:string


### User

Users are people that have logins on the system -or- are volunteers.  Users are typed resources such as:

* User
* Admin
* Volunteer

Some users simply can't login because they will never know their password but if we want to identify a human that will do a task, they will have a user account.

### Event

An event is our **god** object.  Everything hangs off an event.  Here is the rails scaffold command for an event to be generated:

rails g Event name:string location:string address1:string address2:string city:string state:string zip:string time_start:time time_end:time date_start:date date_end:date

### Task

### Speech

### Speaker

### CalendarEntry

A CalendarEntry object supports generation of a calendar.  This is an something that happens on a temporal basis but isn't a first class data object of the system.

### Contact

Contacts are just like a phone's contact record:

rails g scaffold Contact first_name:string last_name:string phone1:string phone2:string url:string email:string signal_username:string 

### ChatTranscript

This is a chat transcript that someone on the system thought was useful knowledge to capture 

### VettingTranscript

A vetting interview is a chat transcript of a signal conversation.  It is a literal copy and paste of a full signal conversation.

rails g VettingTranscript

### VettingQuestion