//
//  ViewController.h
//  SpotifyExample
//
//  Created by Luis de Jesus Martin Castillo on 06/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Spotify/Spotify.h>

@interface Start : UIViewController <SPTAudioStreamingDelegate>

@property (strong, nonatomic) IBOutlet UILabel *songName;

- (IBAction)play:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)prev:(id)sender;

@end

