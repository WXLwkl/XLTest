//
//  ViewController.m
//  BluetoothManagerDemo
//
//  Created by yinjia on 16/4/1.
//  Copyright © 2016年 yjpal. All rights reserved.
//

#import "ViewController.h"

//1.导入头文件,建立主设备管理类,设置主设备委托
#import <CoreBluetooth/CoreBluetooth.h>//蓝牙所用库

@interface ViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    //系统蓝牙设备管理对象,可以把他理解为主设备,通过他,可以扫描和链接外设.
    CBCentralManager *manager;
    
    //用于保存被发现设备
    NSMutableArray *discoverPeripherals;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化并设置委托和线程队列,最好一个线程的参数可以为nil,默认会就main线程
    manager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    
    //持有发现的设备,如果不持有设备会导致CBPeripheralDelegate方法不能正确回调
    discoverPeripherals = [[NSMutableArray alloc]init];
    
}
//2.扫描外设(discover),扫描外设的方式我们放在centralManager成功打开的委托中,因为只有设备成功打开,才能开始扫描,否则报错.
#pragma mark - CBCentralManagerDelegate
//主设备状态改变的委托,在初始化CBCentralManager的是时候回打开设备,只有当设备正确打开后才能使用
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStateUnknown: {
            NSLog(@"CBCentralManagerStateUnknown");
            break;
        }
        case CBCentralManagerStateResetting: {
            NSLog(@"CBCentralManagerStateResetting");
            break;
        }
        case CBCentralManagerStateUnsupported: {
            NSLog(@"CBCentralManagerStateUnsupported");
            break;
        }
        case CBCentralManagerStateUnauthorized: {
            NSLog(@"CBCentralManagerStateUnauthorized");
            break;
        }
        case CBCentralManagerStatePoweredOff: {
            NSLog(@"CBCentralManagerStatePoweredOff");
            break;
        }
        case CBCentralManagerStatePoweredOn: {
            NSLog(@"CBCentralManagerStatePoweredOn");
//开始扫描周围的外设
/*!
 *  @author 逍遥郎happy, 16-04-01 21:04:31
 *
 *  第一个参数nil就是扫描周围所有的外设,  - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
 */
            [central scanForPeripheralsWithServices:nil options:nil];
            break;
        }
    }
}
//找到外设的委托
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"当扫描到设备:%@",peripheral.name);
    
    //接下连接我们的测试设备,
//    if ([peripheral.name hasPrefix:@"P"]) {
        /*
         一个主设备最多能连7个外设，每个外设最多只能给一个主设备连接,连接成功，失败，断开会进入各自的委托
         - (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;//连接外设成功的委托
         - (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//外设连接失败的委托
         - (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error;//断开外设的委托
         */
        
        //找到的设备必须持有它，否则CBCentralManager中也不会保存peripheral，那么CBPeripheralDelegate中的方法也不会被调用！！
        [discoverPeripherals addObject:peripheral];
        
        [manager connectPeripheral:peripheral options:nil];
//    }
    
}
//连接外设成功的委托
-(void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"连接到名称为(%@)的设备->成功",peripheral.name);
    //设置的peripheral委托CBPeripheralDelegate
    //@interface ViewController : UIViewController
    [peripheral setDelegate:self];
    //扫描外设Services，成功后会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    [peripheral discoverServices:nil];
}
//外设连接失败的委托
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"连接到名称为(%@)的设备->失败,原因:%@",peripheral.name,[error localizedDescription]);
}
//断开外设的委托
-(void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"外设连接断开连接%@:%@\n",[peripheral name],[error localizedDescription]);
}

#pragma mark - CBPeripheralDelegate
//4.1获取外设的services
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
//    NSLog(@"扫描到服务:%@",peripheral.services);
    if (error) {
        NSLog(@"Discovered services for %@ with error:%@",peripheral.name,[error localizedDescription]);
        return;
    }
    for (CBService *service in peripheral.services) {
        NSLog(@"%@",service.UUID);
        //扫描每个service的Characteristics，扫描到后会进入方法： -(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
        [peripheral discoverCharacteristics:nil forService:service];
    }
}
//4.2获取外设的Characteristics,获取Characteristics的值，获取Characteristics的Descriptor和Descriptor的值
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {
        NSLog(@"error Discovered characteristics for%@ with error:%@",service.UUID,[error localizedDescription]);
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics)
    {
        NSLog(@"service:%@ 的 Characteristic: %@",service.UUID,characteristic.UUID);
    }

    //获取Characteristic的值，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    for (CBCharacteristic *characteristic in service.characteristics) {
        [peripheral readValueForCharacteristic:characteristic];
    }
    //搜索Characteristic的Descriptors，读到数据会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
    for (CBCharacteristic *characteristic in service.characteristics){
        [peripheral discoverDescriptorsForCharacteristic:characteristic];
    }
}
//获取的characteristic的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    //打印出characteristic的UUID和值
    //注意:value的类型是NSData,具体开发时,会根据外设协议制定的方式去解析数据
    NSLog(@"characteristic UUID:%@ value:%@",characteristic.UUID,characteristic.value);
}
//搜索到characteristic的Descriptors.
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    //打印出characteristic和他的Descriptors
    NSLog(@"characteristic uuid:%@",characteristic.UUID);
    
    for (CBDescriptor *d in characteristic.descriptors) {
        NSLog(@"Descriptor uuid:%@",d.UUID);
    }
}

//获取到Descriptors的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error {
    //打印出Descriptors的UUID和value.
    //这个descriptor都是对于characteristic的描述，一般都是字符串，所以这里我们转换成字符串去解析
    NSLog(@"characteristic uuid:%@ value:%@",[NSString stringWithFormat:@"%@",descriptor.UUID],descriptor.value);
}


//6.订阅Characteristic的通知

//设置通知
-(void)notifyCharacteristic:(CBPeripheral *)peripheral
             characteristic:(CBCharacteristic *)characteristic{
    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    
}

//取消通知
-(void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral
                   characteristic:(CBCharacteristic *)characteristic{
    
    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
}

//7.断开连接(disconnect)
//停止扫描并断开连接
-(void)disconnectPeripheral:(CBCentralManager *)centralManager peripheral:(CBPeripheral *)peripheral {
    //停止扫描
    [centralManager stopScan];
    //断开连接
    [centralManager cancelPeripheralConnection:peripheral];
}

@end
