//
//  ViewController.m
//  模拟.04
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 Cijian.Wu. All rights reserved.
//

#import "ViewController.h"
#import "CJTool.h"
#import "MJRefresh.h"
#import "AFNetworking.h"
#import "CJFirstTableViewCell.h"
#import "CJSecondTableViewCell.h"
#import "CJDetailsViewController.h"
#import "CJTravelViewController.h"

#define FIRST_CELL_URL @"http://guide.selftravel.com.cn/api/v3/get_main/"

#define SECOND_CELL_URL @"http://guide.selftravel.com.cn/api/recommend_route_list?limit=10&offset=%ld"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** URL */
@property(nonatomic,copy)NSString *URL;
/** 数据源 */
@property(nonatomic,strong)NSMutableArray *dataArrM;

/** url请求长度 */
@property(nonatomic,assign)NSInteger offset;
/** 是否向上拉 */
@property(nonatomic,assign,getter=isDropUp)BOOL dropUp;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@",NSHomeDirectory());
    
    self.tabBarController.tabBar.tintColor = [UIColor blackColor];
    //初始化界面
    [self setUI];
    
    //加载本地缓存
    CJTool *tool = [CJTool sharedTool];
    NSArray *arr = [tool searchModelName:@"Group"];
    if (arr.count != 0) {
        //第一种cell数据
        for (CJFirstCellGroupModel *model in arr) {
            [self.dataArrM addObject:model];
        }
        
        NSArray *array = [tool searchModelName:@"Model"];
        
        if (array.count !=0) {
            //第二种cell数据
            for (CJModel *model in array) {
                [self.dataArrM addObject:model];
            }
        }
    }else
    {
        //初始化数据
        [self initData];
    }
    
    //添加按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(10, 30, 40, 40);
    [btn setBackgroundImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
}

- (void)setUI
{
    self.URL = FIRST_CELL_URL;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.dropUp = YES;
        if (_dataArrM.count == 3) {
            _URL = FIRST_CELL_URL;
        }else
        {
            _URL = [NSString stringWithFormat:SECOND_CELL_URL,_offset+ 10];
        }
        [self loadData];
    }];
    _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _URL = [NSString stringWithFormat:SECOND_CELL_URL,_offset+ 10];
        [self loadData];
    }];
    
}

-(NSMutableArray *)dataArrM
{
    if (_dataArrM == nil) {
        _dataArrM = [NSMutableArray array];
    }
    return _dataArrM;
}

-(void)initData
{
    [self.dataArrM removeAllObjects];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *arr = responseObject[@"data"][@"list"];
        for (NSDictionary *dict in arr) {
            CJFirstCellGroupModel *model = [[CJFirstCellGroupModel alloc] initWithDictionary:dict error:nil];
            [self.dataArrM addObject:model];
            [[CJTool sharedTool] insertToName:@"Group" withModel:model];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)loadData
{
    if (self.isDropUp) {
        if (self.dataArrM.count == 3) {
            [self initData];
        }
        else
        {
            for (NSInteger i = self.dataArrM.count - 1; i>2; i--) {
                [_dataArrM removeObjectAtIndex:i];
            }
            _URL = [NSString stringWithFormat:SECOND_CELL_URL,[@0 integerValue]];
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager GET:_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSArray *arr = responseObject[@"data"][@"list"];
                for (NSDictionary *dict in arr) {
                    CJModel *model = [[CJModel alloc] initWithDictionary:dict error:nil];
                    [self.dataArrM addObject:model];
                    [[CJTool sharedTool] insertToName:@"Model" withModel:model];
                }
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
                [_tableView reloadData];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        self.dropUp = NO;
        
    }else
    {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *arr = responseObject[@"data"][@"list"];
            for (NSDictionary *dict in arr) {
                CJModel *model = [[CJModel alloc] initWithDictionary:dict error:nil];
                [self.dataArrM addObject:model];
                [[CJTool sharedTool] insertToName:@"Model" withModel:model];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            [_tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArrM.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row < 3) {
        //第一种cell
        CJFirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first"];
        CJFirstCellGroupModel *model = self.dataArrM[indexPath.row];
        cell.model = model;
        return cell;
    }else
    {
        //第二种cell
        CJSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"second"];
        CJModel *model = self.dataArrM[indexPath.row];
        cell.model = model;
        return cell;
    }
}
#pragma mark - 设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row <3) {
        return 222;
    }
    return 250;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 3) {
        CJFirstCellGroupModel *model = self.dataArrM[indexPath.row];
        CJDetailsViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"details"];
        VC.name = model.name;
        [self.navigationController pushViewController:VC animated:YES];
    }else
    {
        CJModel *model = self.dataArrM[indexPath.row];
        CJTravelViewController *VC = [self.storyboard instantiateViewControllerWithIdentifier:@"travel"];
        VC.model = model;
        [self.navigationController pushViewController:VC animated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
