//
//  FISDataStoreSpec.m
//  slapChat
//
//  Created by Daniel Barabander on 3/26/15.
//  Copyright 2015 Joe Burgess. All rights reserved.
//

#import "Specta.h"
#import "FISDataStore.h"
#import "Message.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "KIF.h"


SpecBegin(FISDataStore)

describe(@"FISDataStore", ^{
    __block FISDataStore *dataStore;
    __block NSManagedObjectContext *testingContext;
    
    beforeAll(^{
        dataStore = [FISDataStore sharedDataStore];

    });
    
    beforeEach(^{
        NSBundle *bundle =
        [NSBundle bundleForClass:NSClassFromString(@"FISDataStore")];
        
        NSString *path =
        [bundle pathForResource:@"slapChat" ofType:@"momd"];
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
        dataStore.managedObjectContext = testingContext;

    });
    
    describe(@"Singleton Initialization", ^{
        it(@"should only be created once", ^{
            expect(dataStore).to.equal(dataStore);
        });
        it(@"should return a DataStore Instance", ^{
            expect(dataStore).to.beKindOf([FISDataStore class]);
        });
    });
    
    describe(@"managed object context", ^{
        it(@"is initialized", ^{
            expect(dataStore.managedObjectContext).to.equal(testingContext);
        });
    });
    
    describe(@"fetchData", ^{
        
        context(@"when empty", ^{
            beforeEach(^{
                [dataStore fetchData];
            });
            
            it(@"should include three pirates", ^{
                expect([dataStore.messages count]).to.equal(3);
            });
            
            it(@"should have four ships for the second pirate", ^{
                expect([((Message *)dataStore.messages[0]) content]).to.equal(@"Message 1");
            });
            
        });
    });
    
    describe(@"managed object context", ^{
        it(@"is initialized", ^{
            expect(dataStore.managedObjectContext).to.equal(testingContext);
        });
    });

  });

SpecEnd
