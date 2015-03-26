//
//  FISTableViewControllerSpec.m
//  
//
//  Created by Daniel Barabander on 3/19/15.
//  Copyright 2015 __MyCompanyName__. All rights reserved.
//

#import "Specta.h"
#import "FISTableViewController.h"
#import "FISDataStore.h"
#import "Message.h"
#import "FISAppDelegate.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "KIF.h"

SpecBegin(FISTableViewController)

describe(@"FISTableViewController", ^{
    
//    __block FISDataStore *store;
    __block NSManagedObjectContext *testingContext = [[NSManagedObjectContext alloc] init];
    
    beforeEach(^{

        NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"FISDataStore")];
        NSString *path = [bundle pathForResource:@"slapChat" ofType:@"momd"];
        NSURL *momdURL = [NSURL fileURLWithPath:path];
        NSManagedObjectModel *model =
        [[NSManagedObjectModel alloc] initWithContentsOfURL:momdURL];
        NSPersistentStoreCoordinator *coord =
        [[NSPersistentStoreCoordinator alloc]
         initWithManagedObjectModel:model];
        [coord addPersistentStoreWithType:NSInMemoryStoreType
                            configuration:nil URL:nil options:nil error:nil];
        testingContext = [[NSManagedObjectContext alloc] init];
        [testingContext setPersistentStoreCoordinator:coord];
        [FISDataStore sharedDataStore].managedObjectContext = testingContext;
        [[FISDataStore sharedDataStore] fetchData];
    });

    describe(@"TableView", ^{
        it(@"should have three rows", ^{
            UITableView *tableView = (UITableView *)[tester waitForViewWithAccessibilityLabel:@"TableView"];
            [tableView reloadData];
            expect([tableView numberOfRowsInSection:0]).to.equal(3);
        });
    });
        
        it(@"should display the messages name in the text field, in sorted order", ^{
            NSIndexPath *row = [NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"TableView"];
            expect(cell.textLabel.text).to.equal(@"Message 1");
            
            row = [NSIndexPath indexPathForRow:1 inSection:0];
            cell = (UITableViewCell *)[tester waitForCellAtIndexPath:row inTableViewWithAccessibilityIdentifier:@"TableView"];
            
            expect(cell.textLabel.text).to.equal(@"Message 2");
        });
    });

SpecEnd