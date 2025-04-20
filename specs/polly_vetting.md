# Polly :: Vetting Features

Polly or Political Event Manager is an open source platform for building political events. Polly is being developed here at Indiana 50501 to facilitate our work combatting the current administration.   

The first feature of Polly is **vetting**.

Vetting is the process of asking a human questions to determine:

* Good actor or bad actor (in the security sense)
* What are their skills
* Where can they aid the organization

Right now vetting for Indiana 50501 is a manual process that is:

* ad hoc
* informal
* poorly implemented
* done without any record keeping at all

The end result is, predictably,  shitty.

Here are the data tables that are needed for a vetting facility:

* VettingDocument -- this records the question and answer process between the questioner (someone in leadership) and the person being vetted
* VettingQuestions -- this is a set of prebuilt questions for the vetter to ask the vettee.  These questions may be categorical in nature i.e. "ask the right questions for someone who wants to do graphics" versus general questions ("who are you", "are you a trumper")

## User Interface 

## Rails Steps

rails g scaffold VettingDocument name:string body:text belongs_to:user

rails g scaffold VettingQuestion name:string body:text belongs_to:user

rails g scaffold VettingQuestionType name:string belongs_to:user

rails g scaffold Contact first_name:string last_name:string phone1:string phone2:string phone3:string email:string url1:string url2:string

## Searchable

Note: All of this needs to be searchable

## OTHER

Copy and paste of the chat conversation so we can track WHO DID IT and WHAT WAS ASKED

auto creation of a farley file contact record when a phone number or email is detected or url 

Yes it will lead to duplicate records; cie la vie