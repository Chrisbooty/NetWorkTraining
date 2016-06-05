//
//  CJTravelViewController.m
//  NetworkTraining
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 Cijian.Wu. All rights reserved.
//

#import "CJTravelViewController.h"
#import "CJTool.h"

@interface CJTravelViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation CJTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://h5.jieke100.com/client/jieke/pages/route.html?id=%@",self.model.route_id]]]];
    _webView.backgroundColor = [UIColor whiteColor];
    _btn.layer.cornerRadius = 10;
    _btn.clipsToBounds = YES;
    _btn.layer.borderColor = [UIColor whiteColor].CGColor;
    _btn.layer.borderWidth = 1.0f;
    
}
- (IBAction)backClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)btnClick {
    [self alertShow:self.model.collect];
}

- (void)alertShow:(NSNumber *)info
{
    NSString *str;
    if (info.intValue) {
        str = @"已经预约,请不要重复预约!";
    }else
    {
        str = @"预约成功!";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (info.intValue == 0) {
            self.model.collect = @1;
            [[CJTool sharedTool] saveData];
        }
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
