//
//  CJDetailsViewController.m
//  NetworkTraining
//
//  Created by mac on 16/6/5.
//  Copyright © 2016年 Cijian.Wu. All rights reserved.
//

#import "CJDetailsViewController.h"
#import "AFNetworking.h"
#import "CJModel.h"
#import "MJRefresh.h"
#import "CJSecondTableViewCell.h"
#import "CJTravelViewController.h"
#import "CJTool.h"

@interface CJDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;

/** 数据源 */
@property(nonatomic,strong)NSMutableArray *dataDetailsArrM;

/** url */
@property(nonatomic,copy)NSString *URL;

@end

@implementation CJDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleL.text = self.name;

    _URL = [[NSString stringWithFormat:@"http://guide.selftravel.com.cn/api/v3/get_routes_list/?label=%@&offset=0&ctype=1&limit=10",self.name] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSLog(@"%@",_URL);
    
    [self requestData];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [self requestData];
    }];
}

-(NSMutableArray *)dataDetailsArrM
{
    if (_dataDetailsArrM == nil) {
        _dataDetailsArrM = [NSMutableArray array];
    }
    return _dataDetailsArrM;
}

- (void)requestData
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.dataDetailsArrM removeAllObjects];
        NSArray *arr = responseObject[@"data"][@"list"];
        for (NSDictionary *dict in arr) {
            CJModel *model = [[CJModel alloc] initWithDictionary:dict error:nil];
            [self.dataDetailsArrM addObject:model];
            [[CJTool sharedTool] insertToName:@"Model" withModel:model];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataDetailsArrM.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CJSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"details"];
    CJModel *model = self.dataDetailsArrM[indexPath.row];
    cell.model = model;
    return cell;
}

- (IBAction)backClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CJModel *model = self.dataDetailsArrM[indexPath.row];
    CJTravelViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"travel"];
    VC.model = model;
    [self.navigationController pushViewController:VC animated:YES];
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
