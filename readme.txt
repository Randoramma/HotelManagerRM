Welcome to HotelManagerRM.  This was a class assignment project during my Code Fellows iOS Development Accelerator. The purpose of this app is to demonstrate the following: 
  1. Demonstration of knowledge of VFL (Visual Format Lanugage).
  2. Demonstration of knowledge of Core Data / iOS persistence. 
  3. Demonstration of knowledge of use of iCloud to back up Core Data. 
  
  
The purpose of this application is to allow a user (Such as a hotel manager) to observe 4 Different hotels and perhaps some information about these establishements.  

Allow the user to determine which rooms are available during a given time range. 

Allow the user to make a reservation for a room during a time frame.  

Admittely I was unable to complete this project during the bootcamp.  As I do not like to leave projects incomplete I am returning to complete this assignment.  As I have recently spent a lot of time with Core Data I am updating the stack to implement a take off of the (from what I have observed) popular and effective for this purpose Marcus Zarra's core data stack.  The setup of this stack utilizes the parent child MOC concept with a private MOC soley interacting with the PSC and a public readonly MOC providing data access to the view controllers.  Also there are throwaway private MOC's being used to async save data to the main MOC.  
 Marcus Zarra's original concept and desing can be found :  http://martiancraft.com/blog/2015/03/core-data-stack/
 An additional video can be found here:  https://www.youtube.com/watch?v=ckbke8vjHMw
 
 Thanks for reading! 

