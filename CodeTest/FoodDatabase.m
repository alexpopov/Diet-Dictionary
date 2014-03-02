//
//  FoodDatabase.m
//  CodeTest
//
//  Created by Alex Popov II on 2014-03-01.
//  Copyright (c) 2014 Alex Popov II. All rights reserved.
//

#import "FoodDatabase.h"
#import "FoodInfo.h"

@implementation FoodDatabase

static FoodDatabase *_database;

// construct database
+ (FoodDatabase*)database {
    // is no data, create one
    if (_database == nil) {
        _database = [[FoodDatabase alloc] init];
    }
    return _database;
}

- (id)init {
    if ((self = [super init])) {
        NSString *sqLiteDb = [[NSBundle mainBundle] pathForResource:@"food"
                                                             ofType:@"sqlite"];
        NSLog(@"Database name: %@", sqLiteDb);
        // error handle
        if (sqlite3_open([sqLiteDb UTF8String], &_database) != SQLITE_OK) {
            NSLog(@"Failed to open database!");
        } else {
            NSLog(@"Opened Database");
        }
    }
    return self;
}

- (NSArray *)foodInfos {
    NSLog(@"Did Call: foodInfos");
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    // SUPER IMPORTANT GET THIS ONE RIGHT
    NSString *query = [NSString stringWithFormat:NSLocalizedString(@"SELECT FOOD INDO", nil)];
    // will hold SQLite return statement
    sqlite3_stmt *statement;
    // call the API on '_database' with 'query', put into 'statement'
    int sqliteErrorCode = sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil);
    NSLog(@"%s while preparing statement", sqlite3_errmsg(_database));
    if (sqliteErrorCode == SQLITE_OK) {
        // iterate over all returned statements
        while (sqlite3_step(statement) == SQLITE_ROW) {
            /* example of sqlite return
             502105	TURKEY, BROILER, THIGH, MEAT AND SKIN, ROASTED	Poultry Products
             502106	TURKEY, BROILER, THIGH, MEAT ONLY, RAW	Poultry Products
             502107	TURKEY, BROILER, THIGH, MEAT ONLY, ROASTED	Poultry Products
             502108	TURKEY, ALL CLASSES, BACK, MEAT ONLY, ROASTED	Poultry Products
             502109	TURKEY, ALL CLASSES, BACK, MEAT ONLY, RAW	Poultry Products
             502110	SAUCE, HOLLANDAISE (BUTTER SAUCE)	Soups, Sauces and Gravies             */
            // Food_ID is column 0
            int fd_id = sqlite3_column_int(statement, 0);
            // FOOD_NAME is column 1
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            // FOOD_GROUP is column 2
            char *groupChars = (char *) sqlite3_column_text(statement, 2);
            // change UTF8 chars into Strings (that's what we work with)
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *group = [[NSString alloc] initWithUTF8String:groupChars];
            // Make an object to store our Info. Initialize with #, name and group
            FoodInfo *info = [[FoodInfo alloc]
                                    initWithFoodID:fd_id name:name group:group];
            // append object to our Array of values
            [retval addObject:info];
        }
        // Reset query
        sqlite3_finalize(statement);
    }
    return retval;
    
}

- (NSArray *)foodDetails:(int)fd_id {
    NSLog(@"Did Call: foodDetails");
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    // SUPER IMPORTANT GET THIS ONE RIGHT
    NSString *query = [NSString stringWithFormat:NSLocalizedString(@"SELECT FOOD DETAILS", nil), fd_id ];
    // will hold SQLite return statement
    sqlite3_stmt *statement;
    // call the API on '_database' with 'query', put into 'statement'
    int sqliteErrorCode = sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil);
    NSLog(@"%s while preparing statement", sqlite3_errmsg(_database));
    if (sqliteErrorCode == SQLITE_OK) {
        // iterate over all returned statements
        while (sqlite3_step(statement) == SQLITE_ROW) {
            /* example of sqlite return
             PROTEIN	4.074
             ALCOHOL	0
             IRON	0.594
             FOLIC ACID	0.47881
             */
            char *nameChars = (char *) sqlite3_column_text(statement, 0);
            NSNumber *value = [NSNumber numberWithDouble:sqlite3_column_double(statement, 1)];
            char *unitChars = (char *) sqlite3_column_text(statement, 2);
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *unit = [[NSString alloc] initWithUTF8String:unitChars];
            if (unit == nil) {
                unit = @"";
            }
            if ([value boolValue]) {
                [retval addObject:@[name, value, unit]];
            }
            // NSLog(@"%@\t %@\t%@", name, value, unit);
            
        }
        // Reset query
        sqlite3_finalize(statement);
    }
    return retval;
    
}

- (NSArray *)foodList:(int)fd_grp_id {
    NSLog(@"Did Call: foodList");
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    // SUPER IMPORTANT GET THIS ONE RIGHT
    NSString *query = [NSString stringWithFormat:NSLocalizedString(@"SELECT FOOD LIST", nil), fd_grp_id ];
    // will hold SQLite return statement
    sqlite3_stmt *statement;
    // call the API on '_database' with 'query', put into 'statement'
    int sqliteErrorCode = sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil);
    NSLog(@"%s while preparing statement", sqlite3_errmsg(_database));
    if (sqliteErrorCode == SQLITE_OK) {
        // iterate over all returned statements
        while (sqlite3_step(statement) == SQLITE_ROW) {
            /* example of sqlite return
             232	BABYFOOD, BAKED PRODUCTS, TEETHING BISCUITS
             234	BABYFOOD, BAKED PRODUCTS, CRACKERS, CHEDDAR, HEINZ
             237	BABYFOOD, DINNERS, CASSEROLE W/ CHICKEN, TODDLER, HEINZ            */
            // Food_ID is column 0
            int fd_id = sqlite3_column_int(statement, 0);
            // FOOD_NAME is column 1
            char *nameChars = (char *) sqlite3_column_text(statement, 1);
            // FOOD_GROUP is column 2
            char *groupChars = (char *) sqlite3_column_text(statement, 2);
            // change UTF8 chars into Strings (that's what we work with)
            NSString *name = [[NSString alloc] initWithUTF8String:nameChars];
            NSString *group = [[NSString alloc] initWithUTF8String:groupChars];
            // Make an object to store our Info. Initialize with #, name and group
            FoodInfo *info = [[FoodInfo alloc]
                              initWithFoodID:fd_id name:name group:group];
            // append object to our Array of values
            [retval addObject:info];
        }
        // Reset query
        sqlite3_finalize(statement);
    }
    return retval;
    
}



- (NSArray *)foodGroups {
    NSLog(@"Did Call: foodGroups");
    NSMutableArray *retval = [[NSMutableArray alloc] init];
    // SUPER IMPORTANT GET THIS ONE RIGHT
    NSString *query = @"SELECT FD_GRP_ID ,FD_GRP_NME FROM food_groups ORDER BY FD_GRP_NME;";
    // will hold SQLite return statement
    sqlite3_stmt *statement;
    // call the API on '_database' with 'query', put into 'statement'
    int sqliteErrorCode = sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil);
    NSLog(@"%s while preparing statement", sqlite3_errmsg(_database));
    if (sqliteErrorCode == SQLITE_OK) {
        // iterate over all returned statements
        while (sqlite3_step(statement) == SQLITE_ROW) {
            /* example of sqlite return
             Dairy and Egg Products
             Spices and Herbs
             Babyfoods
             */
            // Food_ID is column 0
            int fd_grp_id = sqlite3_column_int(statement, 0);
            // FOOD_NAME is column 1
            char *groupChars = (char *) sqlite3_column_text(statement, 1);
            // FOOD_GROUP is column 2
            // change UTF8 chars into Strings (that's what we work with)
            NSString *group = [[NSString alloc] initWithUTF8String:groupChars];
            NSString *name = @"name";
            // Make an object to store our Info. Initialize with #, name and group
            FoodInfo *info = [[FoodInfo alloc]
                              initWithFoodID:fd_grp_id name:name group:group];
            // append object to our Array of values
            [retval addObject:info];
        }
        // Reset query
        sqlite3_finalize(statement);
    }
    return retval;
    
}

@end
