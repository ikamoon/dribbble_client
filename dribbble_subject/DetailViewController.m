//
//  DetailViewController.m
//  dribbble_subject
//
//  Created by ikamon on 2014/04/21.
//  Copyright (c) 2014年 Koari Ikada. All rights reserved.
//

#import "DetailViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface DetailViewController ()

@end

@implementation DetailViewController {
    NSDictionary *shotData;
}

- (id)initWithShotData:(NSDictionary *)shot
{
    self = [super init];
    if (self) {
        shotData = shot;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, self.view.frame.size.width - 10, self.view.frame.size.width - 10)];
    [image setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [shotData objectForKey:@"image_url"]]]];
    image.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:image];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
