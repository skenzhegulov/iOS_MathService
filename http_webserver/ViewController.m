//
//  ViewController.m
//  push_test
//
//  Created by SAKEN KENZHEGULOV on 1/19/16.
//  Copyright © 2016 saken_usis_intern. All rights reserved.
//

#import "ViewController.h"
#import "Classes/ASIFormDataRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.result.text = @"no result";
}

//Button click event listener
- (IBAction)btn:(id)sender {
    //Generating an URL for the web service request
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.22:80/MathService.asmx/Add"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    
    //Passing values for Add(int a, int b) method
    [request setPostValue:self.fld1.text forKey:@"a"];
    [request setPostValue:self.fld2.text forKey:@"b"];
    //Sending request
    [request setDelegate:self];
    [request startAsynchronous];
    
}

//Web service response
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"status code %d",request.responseStatusCode);
    //If response status is success
    if(request.responseStatusCode == 200)
    {
        NSLog(@"success");
        //Receive response message
        NSString *responseString = [request responseString];
        NSLog(@"%@",responseString);
        //Convert to JSON format
        NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: nil];
        //Retrieve data from JSON
        NSNumber *res = [json valueForKey:@"res"];
        
        NSLog(@"%@",[json description]);
        NSLog(@"%@",res);
        //Print on the screen
        NSString *myString = [res stringValue];
        self.result.text = myString;
    }
    
    NSLog(@"request finished");
}

//If request failed, output an error message
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@",error.localizedDescription);
 
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end