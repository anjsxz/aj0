//
//  Record.m
//  record
//
//  Created by anjun on 6/20/14.
//  Copyright (c) 2014 anjun. All rights reserved.
//

#import "Record.h"
static Record* _shared;
@implementation Record{
    NSTimer*timer;
}
+(Record*)shared{
    if (!_shared) {
        _shared = [Record new];
    }
    return _shared;
}
-(void)record{
    [self  genFile ];
    self.recorder = [[AVAudioRecorder alloc] initWithURL:self.recordedFile settings:nil error:nil];
    if ([_recorder prepareToRecord]) {
        //开始
        [_recorder record];
         NSLog(@"start...");
    }
}
-(void)stop{
     [_recorder stop];
     [self record];
     NSLog(@"stop...");
}
-(void)play{
}
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    NSLog(@"did finish");
}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error{
    NSLog(@"%@",error);
}
- (void)audio
{
    self.isRecording = NO;
   
    _player.delegate = self;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    
    NSError *sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(session == nil)
        NSLog(@"Error creating session: %@", [sessionError description]);
    else
        [session setActive:YES error:nil];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:600 target:self selector:@selector(stop) userInfo:nil repeats:YES];
     [self  genFile ];
  
    [self record];
    
/*
    //录音设置
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc]init];
    //设置录音格式  AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    //设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    NSString *strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/lll.aac", strUrl]];
    urlPlay = url;
    
    NSError *error;
    //初始化
    recorder = [[AVAudioRecorder alloc]initWithURL:url settings:recordSetting error:&error];
    //开启音量检测
    recorder.meteringEnabled = YES;
    recorder.delegate = self;
 */
}
-(void)genFile{
  
    NSDateFormatter *dfmt = [NSDateFormatter new];
    dfmt.dateFormat = @"YMMddHHmm";
    NSString*datestring=   [dfmt stringFromDate:[NSDate new]];
    NSString*docment=  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString*filepath =[docment stringByAppendingPathComponent:datestring];
    NSString*ff = [NSString stringWithFormat:@"%@%@",filepath,@".caf"];
    _recordedFile = [NSURL fileURLWithPath:ff];
    NSLog(@"_recordedFile:%@",_recordedFile);
}
@end
