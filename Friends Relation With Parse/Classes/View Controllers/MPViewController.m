//
//  MPViewController.m
//  Friends Relation With Parse
//
//  Created by Mitchell Porter on 8/4/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "MPViewController.h"
#import <Parse/Parse.h>

@interface MPViewController ()

@end

@implementation MPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
#pragma mark - Add Friends Relation
    //Create a relation object. Remember to insert the name of your relation key
    PFRelation *friendsRelationForAdding = [[PFUser currentUser]relationforKey:@"INSERT-RELATION-KEY"];
    
    //Below is the user that the current user would like to add to their friends list
    //The commented line is an example of how I set the user based on a table view selection
    //PFUser *userToAdd = [self.parseUsers objectAtIndex:indexPath.row];

    PFUser *userToAdd;
    
    //Get the currently logged in user
    PFUser *currentUser = [PFUser currentUser];
    
    //Add the user to the relation
    [friendsRelationForAdding addObject:userToAdd];
    
    //Save the current user
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"%@ %@", error, [error userInfo]);
        }
    }];
    
    //Trigger cloud code for the user that is not currently logged in
    [PFCloud callFunction:@"editUser" withParameters:@{
                                                       @"userId": userToAdd.objectId
                                                       }];
    
#pragma mark - Remove Friends Relation
    
    //Create a relation object. Remember to insert the name of your relation key
    PFRelation *friendsRelationForRemoving = [[PFUser currentUser]relationforKey:@"INSERT-RELATION-KEY"];
    
    //Below is the user that the current user would like to remove from their friends list
    //The commented line is an example of how I set the user based on a table view selection
    //PFUser *userToRemove = [self.parseUsers objectAtIndex:indexPath.row];
    
    PFUser *userToRemove;
    
    //Remove the user from the relation
    [friendsRelationForRemoving removeObject:userToRemove];
    
    //Save the current user
    [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"%@ %@", error, [error userInfo]);
        }
    }];

    
}

@end
