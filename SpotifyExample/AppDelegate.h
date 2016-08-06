//
//  AppDelegate.h
//  SpotifyExample
//
//  Created by Luis de Jesus Martin Castillo on 06/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Spotify/Spotify.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,SPTAudioStreamingDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

