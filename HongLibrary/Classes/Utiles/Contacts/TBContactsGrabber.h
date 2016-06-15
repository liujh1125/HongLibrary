//
//  TBContactsGrabber.h
//  MultiSelectUIXibVersion
//
//  Created by Aditya Narayan on 10/28/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import "Contact.h"

@protocol TBContactsGrabberDelegate <NSObject>
@optional
- (void) didFinishGrabbingContactsFromAddressBook;

@end

@interface TBContactsGrabber : NSObject

@property (nonatomic, strong) NSMutableArray *savedArrayOfContactsWithPhoneNumbers;
@property (nonatomic, assign) id<TBContactsGrabberDelegate> delegate;


- (void) runGrabContactsOnBackgroundQueue;
- (void) checkForABAuthorizationAndStartRun;
- (void) grabContactsWithAPhoneNumber;

- (Contact *) createContactObjectBasedOnAddressBookRecord: (ABRecordRef) myABRecordRef;
- (Contact *) phoneNumberPrioritizationLogic: (Contact *) myContactObject ABmultivalueref: (ABMultiValueRef) mvr;

- (void) startListeningForABChanges;
- (void) addNewContactsIntoCustomArray;

- (void) logOutSavedArray;



@end


