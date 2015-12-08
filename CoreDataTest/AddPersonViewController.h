//
//  ViewController.h
//  coreDataTest
//
//  Created by Cafex-Development on 07/12/15.
//  Copyright © 2015 Cafex-Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AddPersonViewController : UIViewController
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

