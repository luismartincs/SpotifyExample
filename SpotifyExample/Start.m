//
//  ViewController.m
//  SpotifyExample
//
//  Created by Luis de Jesus Martin Castillo on 06/08/16.
//  Copyright © 2016 Luis de Jesus Martin Castillo. All rights reserved.
//

#import "Start.h"

@interface Start ()
@property (nonatomic, strong) SPTAudioStreamingController *player;
@property (nonatomic,strong) SPTPlaylistSnapshot *playlistSnapshot;
@end

@implementation Start

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Construct a login URL and open it
    NSURL *loginURL = [[SPTAuth defaultInstance] loginURL];
    
    // Opening a URL in Safari close to application launch may trigger
    // an iOS bug, so we wait a bit before doing so.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginUsingSession) name:@"loginEvent" object:nil];
    
    [[UIApplication sharedApplication] performSelector:@selector(openURL:)
                      withObject:loginURL afterDelay:0.1];
}

//============ Spotify ================



-(void)loginUsingSession {
    
    SPTSession *session = [SPTAuth defaultInstance].session;
    
    // Get the player instance
    self.player = [SPTAudioStreamingController sharedInstance];
    self.player.delegate = self;
    // Start the player (will start a thread)
    [self.player startWithClientId:@"2808173d0ba941888a6780fa35d6274a" error:nil];
    // Login SDK before we can start playback
    [self.player loginWithAccessToken:session.accessToken];
    
}

- (void)audioStreamingDidLogin:(SPTAudioStreamingController *)audioStreaming {
    /* NSURL *url = [NSURL URLWithString:@"spotify:track:7kMZGMJlckd50Mhfaq7gVD"];
     [self.player playURI:url callback:^(NSError *error) {
     if (error != nil) {
     NSLog(@"*** failed to play: %@", error);
     return;
     }
     }];*/
    NSURL *playlist = [NSURL URLWithString:@"spotify:user:luis_martin:playlist:7w5i5cvxXDtbyLocNFqxqk"];
    
    
    NSString *accessToken = [SPTAuth defaultInstance].session.accessToken;
    NSURLRequest *playlistReq = [SPTPlaylistSnapshot createRequestForPlaylistWithURI:playlist
                                                                         accessToken:accessToken
                                                                               error:nil];
    
    [[SPTRequest sharedHandler] performRequest:playlistReq callback:^(NSError *error, NSURLResponse *response, NSData *data) {
        if (error != nil) {
            NSLog(@"*** Failed to get playlist %@", error);
            return;
        }
        
        self.playlistSnapshot = [SPTPlaylistSnapshot playlistSnapshotFromData:data withResponse:response error:nil];
        
        [self.player playURIs:self.playlistSnapshot.firstTrackPage.items fromIndex:0 callback:nil];
        [self.player setIsPlaying:NO callback:nil];
    }];
}

//========


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)play:(id)sender {
    
    NSString *sn = [NSString stringWithFormat:@"%@", [self.playlistSnapshot.firstTrackPage.items[self.player.currentTrackIndex] name]];
    _songName.text =sn;
    [self.player setIsPlaying:YES callback:nil];
}

- (IBAction)stop:(id)sender {
    [self.player setIsPlaying:NO callback:nil];
    _songName.text = @"None";
    [self.player logout];
}

- (IBAction)next:(id)sender {
    
    [self.player skipNext:nil];
    
    NSString *sn = [NSString stringWithFormat:@"%@", [self.playlistSnapshot.firstTrackPage.items[self.player.currentTrackIndex+1] name]];
    _songName.text =sn;

}

- (IBAction)prev:(id)sender {
    [self.player skipPrevious:nil];
    
    NSString *sn = [NSString stringWithFormat:@"%@", [self.playlistSnapshot.firstTrackPage.items[self.player.currentTrackIndex-1] name]];
    _songName.text =sn;

}
@end
