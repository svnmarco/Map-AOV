
#import "Macros.h"
#import "Esp/ImGuiDrawView.h"
#import <Metal/Metal.h>
#import <MetalKit/MetalKit.h>
#import <Foundation/Foundation.h>
#include "KittyMemory/imgui.h"
#include "KittyMemory/imgui_impl_metal.h"
#import <Foundation/Foundation.h>
#import "Esp/CaptainHook.h"
#include <UIKit/UIKit.h>
#import "JRMemory.framework/Headers/MemScan.h"
#import "Esp/API/APIKey.h"
#include "FPSDisplay.h"
#import "Honkai.h"
#include "Icon.h"
#include "Iconcpp.h"
#include "fontch.h"
#include "ico_font.h"
#include "segue_font.h"
#import "NakanoIchika.h"
#import "NakanoNino.h"
#import "NakanoMiku.h"
#import "NakanoYotsuba.h"
#import "NakanoItsuki.h"
#include <sys/sysctl.h>
#import <mach/task_info.h>
#import <mach/task.h>
#include <sys/stat.h>
#include <unistd.h>


ImFont* ico = nullptr;
ImFont* ico_combo = nullptr;
ImFont* ico_button = nullptr;
ImFont* ico_grande = nullptr;
ImFont* segu = nullptr;
ImFont* default_segu = nullptr;
ImFont* bold_segu = nullptr;

#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kScale [UIScreen mainScreen].scale
#define kTest   0 
#define g 0.86602540378444 

@interface ImGuiDrawView () <MTKViewDelegate>
//@property (nonatomic, strong) IBOutlet MTKView *mtkView;
@property (nonatomic, strong) id <MTLDevice> device;
@property (nonatomic, strong) id <MTLCommandQueue> commandQueue;










@end


float headx;
float heady;
#define Red 0x990000ff
#define Green 0x9900FF00
#define Yellow 0x9900ffff
#define Blue 0x99ff0000
#define Pink 0x99eb8cfe
#define White 0xffffffff

@implementation ImGuiDrawView



static bool MenDeal = true;


- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    _device = MTLCreateSystemDefaultDevice();
    _commandQueue = [_device newCommandQueue];

    if (!self.device) abort();

    IMGUI_CHECKVERSION();
    ImGui::CreateContext();
    ImGuiIO& io = ImGui::GetIO(); 
    (void)io;

    ImGui::StyleColorsDarkMode();
    
    io.ConfigWindowsMoveFromTitleBarOnly = true;
    io.IniFilename = NULL;
    static const ImWchar icons_ranges[] = { 0xf000, 0xf3ff, 0 };
    ImFontConfig icons_config;
    ImFontConfig CustomFont;
    CustomFont.FontDataOwnedByAtlas = false;
    icons_config.MergeMode = true;
    icons_config.PixelSnapH = true;
    icons_config.OversampleH = 7;
    icons_config.OversampleV = 7;
    NSString *FontPath = @"/System/Library/Fonts/CoreAddition/Arial.ttf";
    io.Fonts->AddFontFromFileTTF(FontPath.UTF8String, 40.f,NULL,io.Fonts->GetGlyphRangesVietnamese());
        io.Fonts->AddFontFromMemoryCompressedTTF(font_awesome_data, font_awesome_size, 25.0f, &icons_config, icons_ranges);

    
    
    ImGui_ImplMetal_Init(_device);

    return self;
}


+ (void)showChange:(BOOL)open
{
    MenDeal = open;
}

- (MTKView *)mtkView
{
    return (MTKView *)self.view;
}

- (void)loadView
{
    CGFloat w = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width;
    CGFloat h = [UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height;
    self.view = [[MTKView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mtkView.device = self.device;
    self.mtkView.delegate = self;
    self.mtkView.clearColor = MTLClearColorMake(0, 0, 0, 0);
    self.mtkView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.mtkView.clipsToBounds = YES;
}









#pragma mark - Interaction

- (void)updateIOWithTouchEvent:(UIEvent *)event
{
    UITouch *anyTouch = event.allTouches.anyObject;
    CGPoint touchLocation = [anyTouch locationInView:self.view];
    ImGuiIO &io = ImGui::GetIO();
    io.MousePos = ImVec2(touchLocation.x, touchLocation.y);

    BOOL hasActiveTouch = NO;
    for (UITouch *touch in event.allTouches)
    {
        if (touch.phase != UITouchPhaseEnded && touch.phase != UITouchPhaseCancelled)
        {
            hasActiveTouch = YES;
            break;
        }
    }
    io.MouseDown[0] = hasActiveTouch;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateIOWithTouchEvent:event];
}

#pragma mark - MTKViewDelegate



bool isJailbroken() {
    // Kiểm tra file /bin/bash
    struct stat s;
    return (stat("/bin/bash", &s) == 0);
}

- (void)drawInMTKView:(MTKView*)view
{

    ImGuiIO& io = ImGui::GetIO();
    io.DisplaySize.x = view.bounds.size.width;
    io.DisplaySize.y = view.bounds.size.height;

    CGFloat framebufferScale = view.window.screen.scale ?: UIScreen.mainScreen.scale;
    io.DisplayFramebufferScale = ImVec2(framebufferScale, framebufferScale);
    io.DeltaTime = 1 / float(view.preferredFramesPerSecond ?: 60);
    
    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
    
    static bool map = false;
    static bool avatar = false;
    static bool botro = false;
    static bool camxa = false;
    static bool name = false;
    static bool ulti = false;
    static bool rank = false;
    static bool fpscao = false;
    static bool lsd = false;
    static bool aimelsu = false;
    static bool blockreport = false;
    static bool bypasssv = false;
    static bool bypassanti = false;
    static bool mod = false;
    static bool show_s0_active = false;
    static bool hidename = false;
    static bool name_on = false;
    static bool autowin = false;
    static bool autowin_on = false;
    static bool skill0s = false;
    static bool skill0s_on = false;
   static APIClient *apiClient;  


       
        //
        if (MenDeal == true) {
            [self.view setUserInteractionEnabled:YES];
        } else if (MenDeal == false) {
            [self.view setUserInteractionEnabled:NO];
        }

        MTLRenderPassDescriptor* renderPassDescriptor = view.currentRenderPassDescriptor;
        if (renderPassDescriptor != nil)
        {
            id <MTLRenderCommandEncoder> renderEncoder = [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
            [renderEncoder pushDebugGroup:@"ImGui Jane"];

            ImGui_ImplMetal_NewFrame(renderPassDescriptor);
            ImGui::NewFrame();
            
            ImFont* font = ImGui::GetFont();
            font->Scale = 12.f / font->FontSize;
            
            CGFloat x = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.width) - 380) / 2;
            CGFloat y = (([UIApplication sharedApplication].windows[0].rootViewController.view.frame.size.height) - 210) / 2;
            
            ImGui::SetNextWindowPos(ImVec2(x, y), ImGuiCond_FirstUseEver);
            ImGui::SetNextWindowSize(ImVec2(430, 260), ImGuiCond_FirstUseEver);
            
if (MenDeal == true)
{

            std::string namedv = [[UIDevice currentDevice] name].UTF8String;
            NSDate *now = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"EEEE dd/MM/yyyy"];
            NSString *dateString = [dateFormatter stringFromDate:now];

            UIDevice *device = [UIDevice currentDevice];
            device.batteryMonitoringEnabled = YES;

            float batteryLevel = device.batteryLevel * 100;
            NSString *chargingStatus = @"";
            if (device.batteryState == UIDeviceBatteryStateCharging) {
                chargingStatus = @"- Đang Sạc";
            } else if (device.batteryState == UIDeviceBatteryStateFull) {
                chargingStatus = @"- Đầy Pin";
            } else {
                chargingStatus = @"- Đã Ngắt Sạc";
            }

            int numCores;
            size_t len = sizeof(numCores);
            sysctlbyname("hw.ncpu", &numCores, &len, NULL, 0);

          kern_return_t kr;
          task_info_data_t tinfo;
          mach_msg_type_number_t task_info_count = TASK_INFO_MAX;
          
          kr = task_info(mach_task_self(),
                         TASK_BASIC_INFO,
                         (task_info_t)tinfo,
                         &task_info_count);
          if (kr != KERN_SUCCESS) {
            return;
          }

          task_basic_info_t      basic_info;
          thread_array_t         thread_list;
          mach_msg_type_number_t thread_count;
          
          thread_info_data_t     thinfo;
          mach_msg_type_number_t thread_info_count;

          basic_info = (task_basic_info_t)tinfo;
          
          // Calculate RAM usage
          natural_t used_ram = (basic_info->resident_size) / 1024 / 1024;
          // Calculate available RAM
          natural_t free_ram = ([NSProcessInfo processInfo].physicalMemory) / 1024 / 1024 - used_ram;
          char used_ram_str[100];
          char free_ram_str[100];
          
          ImVec4 used_color = ImVec4(0.5f, 0, 0.5f, 1);
          ImVec4 ram_color = ImVec4(1, 1, 0, 1);

        long num_cpus = sysconf(_SC_NPROCESSORS_ONLN);
        long page_size = sysconf(_SC_PAGESIZE);
        long num_pages = sysconf(_SC_PHYS_PAGES);
        long ram_total = num_pages * page_size;



            ImGui::Begin(ICON_FA_ROCKET"  TuanDev ", &MenDeal, ImGuiWindowFlags_NoCollapse);
            ImGui::BeginTabBar("Bar");
           if (ImGui::BeginTabItem(ICON_FA_HOME" Home Page"))
            {
                //het han key va tb
                apiClient = [[APIClient alloc] init]; 

                ImGui::TextColored(ImColor(255, 255, 255), "Hello ");
                ImGui::SameLine();
                ImGui::TextColored(ImColor(255, 255, 255), "%s", namedv.c_str());

                ImGui::TextColored(ImVec4(1.0f, 1.0f, 1.0f, 1.0f), "Trạng Thái: ");
                ImGui::SameLine();
                if (isJailbroken()) {
                    ImGui::TextColored(ImVec4(1.0f, 0.0f, 0.0f, 1.0f), "Đã Jailbreak !");
                }
                else {
                    ImGui::TextColored(ImVec4(0.0f, 1.0f, 0.0f, 1.0f), "Chưa Jailbreak !");
                }


                ImGui::TextColored(ImColor(255, 255, 255), "Key: ");
                ImGui::SameLine();
                ImGui::TextColored(ImColor(255, 0, 0), " %s", [[apiClient getKey] UTF8String]);

                ImGui::TextColored(ImColor(255, 255, 255), "HSD: ");
                ImGui::SameLine();
                ImGui::TextColored(ImColor(255, 0, 0), " %s", [[apiClient getExpiryDate] UTF8String]);

                ImGui::TextColored(ImColor(255, 255, 255), "UDID: ");
                ImGui::SameLine();
                ImGui::TextColored(ImColor(255, 255, 255), " %s", [[apiClient getUDID] UTF8String]);

                ImGui::Separator();
                //thoi gian
                ImGui::TextColored(ImColor(255, 255, 255), "Times: ");
                ImGui::SameLine();
                ImGui::TextColored(ImColor(0, 255, 255), "%s", [dateString UTF8String]);

                ImColor white(255, 255, 255);
                ImGui::TextColored(white, "Battery: ");

                ImColor yellow(255, 255, 0);
                ImGui::SameLine();
                ImGui::TextColored(yellow, " %.0f%%", batteryLevel);

                ImColor green(0, 255, 0);
 
                ImColor red(255, 0, 0);
                ImColor statusTextColor;
                if (device.batteryState == UIDeviceBatteryStateCharging) {
                    statusTextColor = green;
                } else {
                    statusTextColor = red;
                }
                ImGui::SameLine();
                ImGui::TextColored(statusTextColor, "%s", [chargingStatus UTF8String]);

                ImGui::TextColored(white, "Total CPU: ");
                
                ImGui::SameLine();
                ImGui::TextColored(ImColor(0, 255, 0), " %ld bytes", ram_total);
                ImGui::SameLine();
                ImGui::TextColored(ImColor(102, 255, 102), "Core: %ld", num_cpus);







                ImVec4 used_text_color(1, 0, 1, 1);
                ImVec4 used_info_color(1, 1, 0, 1);

                ImGui::TextColored(white, "RAM Usage: ");
                ImGui::SameLine();
                int used_ram_len = snprintf(used_ram_str, sizeof(used_ram_str), "%s: %d MB", "Used", used_ram);

                if (used_ram_len > 0) {
                    ImGui::TextColored(used_text_color, "%s", "Used: ");
                    ImGui::SameLine();
                    ImGui::TextColored(used_info_color, "%d MB", used_ram);
                }
                ImGui::SameLine(); ImGui::TextColored(white, " / ");
                ImGui::SameLine();

                sprintf(free_ram_str, " %d MB", free_ram);
                if (strlen(free_ram_str) > 0) {
                    ImGui::TextColored(ImVec4(0, 1, 0, 1), "Free RAM: ");
                    ImGui::SameLine();
                    ImGui::TextColored(ImVec4(1, 0, 0, 1), "%s", free_ram_str);
                }

                ImGui::Separator();
                ImGui::Separator();
                NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
                const char *bundleIdentifierUTF8 = [bundleIdentifier UTF8String];
                if (bundleIdentifierUTF8 != NULL && strlen(bundleIdentifierUTF8) > 0) {
                    ImGui::TextColored(white, "Bundle: ");
                    ImGui::SameLine();
                    ImGui::TextColored(white, "%s", bundleIdentifierUTF8);
                }

                ImGui::TextColored(white, "Version: 1.51.11 ");

                ImGui::TextColored(red, "# Author: TuanDev");
                ImGui::EndTabItem();
            }
            if (ImGui::BeginTabItem(ICON_FA_CUBES" Menu"))
            {
                 ImGui::Columns(2);
                 ImGui::Separator();

                ImGui::TextColored(ImColor(255, 255, 255), "# Chức Năng Chính ");
                ImGui::Checkbox(ICON_FA_EYE" Hack Map", &map);
                ImGui::Checkbox(ICON_FA_EYE" Hiện Ulti Địch", &ulti);
                ImGui::Checkbox(ICON_FA_EYE" Hiện Time Bổ Trợ", &botro);
                ImGui::Checkbox(ICON_FA_EYE" Hiện Tên Khi Cấm Chọn", &name);
                ImGui::TextColored(ImColor(255, 255, 255), "# Lưu Ý: Mở Luôn Trong Sảnh Game");
                ImGui::Checkbox(ICON_FA_SHIELD" Block Report", &blockreport);
                ImGui::TextColored(ImColor(255, 255, 255), "# Lưu Ý: Vào Trận Rồi Mở Lên");
                ImGui::Checkbox(ICON_FA_SHIELD" Bypass Server", &bypasssv);
                ImGui::Checkbox(ICON_FA_SHIELD" Bypass Antiban", &bypassanti);
                
                ImGui::NextColumn();
                ImGui::Separator();
                ImGui::BeginTabBar("Bar 1");
                
                if (ImGui::BeginTabItem(ICON_FA_CAMERA " View")) {
                    ImGui::TextColored(ImColor(255, 0, 0), "# Chức Năng Chỉ Dành Cho iPhone JB");
                    ImGui::TextColored(ImColor(255, 255, 255), "# Cam Xa Slider");
                    int my_value = 0;
                    bool option1 = true;
                    static bool actived = false;
                    ImGui::Checkbox("Actived", &actived);
                    ImGui::SliderInt("", &my_value, 0, 200);
                    
                    ImGui::EndTabItem();
                  }

                  if (ImGui::BeginTabItem(ICON_FA_CAMERA " Others")) {
                    ImGui::TextColored(ImColor(255, 0, 0), "# Chức Năng Chỉ Dành Cho iPhone JB");
                    ImGui::TextColored(ImColor(255, 255, 255), "# Aimbot Skill ( Khi Tắt Sẽ Văng )");
                    
                    ImGui::Checkbox("Aimbot Elsu", &aimelsu);
                    
                    ImGui::TextColored(ImColor(255, 255, 255), "# Mod Skin Bằng Offset ( NEW )");

                    ImGui::Checkbox("Mod Skin", &mod);
                    ImGui::Checkbox("Auto Win ( BOT )", &autowin);
                    ImGui::Checkbox("Ẩn Tên", &hidename);
                    ImGui::Checkbox("Hồi Chiêu 0s ( BOT )", &skill0s);
                    ImGui::EndTabItem();
                  }
                
                 ImGui::EndTabBar();

                ImGui::Columns(1);
                ImGui::TextColored(ImColor(255, 0, 0), "# Author: TuanDev ");

            ImGui::EndTabItem();
            }
                
                
            

        if (ImGui::BeginTabItem(ICON_FA_FACEBOOK" Contact Me"))
        {



         
         

         
		

		    
		    ImGui::NextColumn();
		    ImGui::TextColored(ImColor(212, 255, 255), "my info =D");
            if (ImGui::Button("Facebook TuanDev"))
            {
                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/svnmarco.Developer"]];
            }
            if (ImGui::Button("Zalo"))
            {
                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://zalo.me/tuandz27"]];
            }

			
         ImGui::EndTabItem();
        }


}



//chuc nang
ImGuiStyle& style = ImGui::GetStyle();

// Thiết lập giao diện người dùng trong suốt
style.Colors[ImGuiCol_WindowBg].w = 0.9f;  // Đặt mức độ đục của nền cửa sổ thành 0 (suốt)

// Thiết lập bo tròn
style.FrameRounding = 15.0f;
style.GrabMinSize = 7.0f;
style.PopupRounding = 2.0f;
style.ScrollbarRounding = 13.0f;
style.ScrollbarSize = 20.0f;
style.TabBorderSize = 0.6f;
style.TabRounding = 6.0f;
style.WindowRounding = 15.0f;
style.Alpha = 1.0f; 
style.WindowTitleAlign = ImVec2(0.5f, 0.5f);


//chuc nang
     if (aimelsu){
        if(show_s0_active == NO){
            vm_unity(ENCRYPTOFFSET("0x579D980"), strtoul(ENCRYPTHEX("0xE303271EC0035FD6"), nullptr, 0));
            vm_unity(ENCRYPTOFFSET("0x61A36D0"), strtoul(ENCRYPTHEX("0xE3008052C0035FD6"), nullptr, 0));
            }
        show_s0_active = YES;
    }
    else{
        if(show_s0_active == YES){
            vm_unity(ENCRYPTOFFSET("0x579D980"), strtoul(ENCRYPTHEX("0xF44FBEA9FD7B01A9"), nullptr, 0));
            vm_unity(ENCRYPTOFFSET("0x61A36D0"), strtoul(ENCRYPTHEX("0xF657BDA9F44F01A9"), nullptr, 0));
            }
        show_s0_active = NO;
    }

    if (mod)
    {
        vm_unity(ENCRYPTOFFSET("0x594C81C"), strtoul(ENCRYPTHEX("0x20008052C0035FD6"), nullptr, 0));
    }       




    if (autowin){
        if(autowin_on == NO){
            vm_unity(ENCRYPTOFFSET("0x521D5BC"), strtoul(ENCRYPTHEX("0xC0035FD6"), nullptr, 0));
           
            }
        autowin_on = YES;
    }
    else{
        if(autowin_on == YES){
            vm_unity(ENCRYPTOFFSET("0x521D5BC"), strtoul(ENCRYPTHEX("0xF657BDA9"), nullptr, 0));
            
            }
        autowin_on = NO;
    }




    if (hidename){
        if(name_on == NO){
            vm_unity(ENCRYPTOFFSET("0x57B7260"), strtoul(ENCRYPTHEX("0x000080D2C0035FD6"), nullptr, 0));
      
            }
        name_on = YES;
    }
    else{
        if(name_on == YES){
            vm_unity(ENCRYPTOFFSET("0x57B7260"), strtoul(ENCRYPTHEX("0xF85FBCA9F65701A9"), nullptr, 0));
    
            }
        name_on = NO;
    }



    if (skill0s){
        if(skill0s_on == NO){
            vm_unity(ENCRYPTOFFSET("0x51EFAAC"), strtoul(ENCRYPTHEX("0xC0035FD6"), nullptr, 0));

            }
        skill0s_on = YES;
    }
    else{
        if(skill0s_on == YES){
            vm_unity(ENCRYPTOFFSET("0x51EFAAC"), strtoul(ENCRYPTHEX("0xFF4301D1"), nullptr, 0));
      
            }
        skill0s_on = NO;
    }



            ImGui::Render();
            ImDrawData* draw_data = ImGui::GetDrawData();
            ImGui_ImplMetal_RenderDrawData(draw_data, commandBuffer, renderEncoder);
          
            [renderEncoder popDebugGroup];
            [renderEncoder endEncoding];

            [commandBuffer presentDrawable:view.currentDrawable];
        }

        [commandBuffer commit];
}

- (void)mtkView:(MTKView*)view drawableSizeWillChange:(CGSize)size
{
    
}


@end
