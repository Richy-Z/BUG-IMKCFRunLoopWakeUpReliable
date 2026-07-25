#import <AppKit/AppKit.h>

@interface ReproDelegate : NSObject <
    NSApplicationDelegate,
    NSTextFieldDelegate
>
@property(nonatomic, strong) NSWindow *window;
@property(nonatomic, strong) NSTextField *field;
- (void)showCharacterPalette:(id)sender;
@end

@implementation ReproDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    (void)notification;

    self.window = [[NSWindow alloc]
        initWithContentRect:NSMakeRect(0.0, 0.0, 720.0, 240.0)
                  styleMask:
                      NSWindowStyleMaskTitled
                      | NSWindowStyleMaskClosable
                      | NSWindowStyleMaskResizable
                    backing:NSBackingStoreBuffered
                      defer:NO];
    [self.window setTitle:@"Test thing"];
    [self.window center];

    self.field = [[NSTextField alloc]
        initWithFrame:NSMakeRect(40.0, 100.0, 640.0, 32.0)];
    [self.field setPlaceholderString:@"Type here, then choose Emoji & Symbols"];
    [self.field setDelegate:self];
    [[self.window contentView] addSubview:self.field];

    [self.window makeKeyAndOrderFront:nil];
    [self.window makeFirstResponder:self.field];
    [NSApp activateIgnoringOtherApps:YES];

    NSLog(@"Native control ready");
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:
    (NSApplication *)sender
{
    (void)sender;
    return YES;
}

- (void)controlTextDidChange:(NSNotification *)notification
{
    NSTextField *field = [notification object];
    NSLog(@"native text: %@", [field stringValue]);
}

- (void)showCharacterPalette:(id)sender
{
    [NSApp orderFrontCharacterPalette:sender];
}

@end

static void InstallMenus(ReproDelegate *delegate)
{
    NSMenu *mainMenu = [[NSMenu alloc] initWithTitle:@""];
    [NSApp setMainMenu:mainMenu];

    NSMenuItem *applicationItem = [[NSMenuItem alloc]
        initWithTitle:@"Test thing"
               action:nil
        keyEquivalent:@""];
    NSMenu *applicationMenu = [[NSMenu alloc]
        initWithTitle:@"Test thing"];
    NSMenuItem *quitItem = [[NSMenuItem alloc]
        initWithTitle:@"Quit Test thing"
               action:@selector(terminate:)
        keyEquivalent:@"q"];
    [applicationMenu addItem:quitItem];
    [applicationItem setSubmenu:applicationMenu];
    [mainMenu addItem:applicationItem];

    NSMenuItem *editItem = [[NSMenuItem alloc]
        initWithTitle:@"Edit"
               action:nil
        keyEquivalent:@""];
    NSMenu *editMenu = [[NSMenu alloc] initWithTitle:@"Edit"];
    NSMenuItem *paletteItem = [[NSMenuItem alloc]
        initWithTitle:@"Emoji & Symbols"
               action:@selector(showCharacterPalette:)
        keyEquivalent:@" "];
    [paletteItem setTarget:delegate];
    [paletteItem setKeyEquivalentModifierMask:
        NSEventModifierFlagControl | NSEventModifierFlagCommand];
    [editMenu addItem:paletteItem];
    [editItem setSubmenu:editMenu];
    [mainMenu addItem:editItem];
}

int main(int argc, const char *argv[])
{
    (void)argc;
    (void)argv;

    @autoreleasepool {
        NSApplication *application = [NSApplication sharedApplication];
        ReproDelegate *delegate = [[ReproDelegate alloc] init];
        [application setActivationPolicy:NSApplicationActivationPolicyRegular];
        [application setDelegate:delegate];
        InstallMenus(delegate);
        [application run];
    }
    return 0;
}
