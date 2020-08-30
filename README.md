# EclipseX - A Universal Nightmode (and more) for iOS 11
Information regarding EclipseX developer API's will be posted here, to aid developers in developing extensions for EclipseX, as well as tweaks compatible with it.

## Extending Eclipse



## API Information

#### Determining if Eclipse is enabled

```
NSDictionary *eclipsePrefs = [[[NSDictionary alloc] initWithContentsOfFile:@"/User/Library/Preferences/com.gmoran.eclipse.plist"]?:[NSDictionary dictionary] copy];

BOOL eclipseTweakEnabled = [[eclipsePrefs objectForKey:@"enabled"] boolValue];

BOOL applicationIsEnabled = [[eclipsePrefs objectForKey:[@"EnabledApps-" stringByAppendingString:[NSBundle mainBundle].bundleIdentifier]]] boolValue];

BOOL isEclipseEnabledInCurrentApplication = eclipseTweakEnabled && applicationIsEnabled;

if (isEclipseEnabledInCurrentApplication) {
    //handle tweak being enabled inside the current process
}


```

#### Having Eclipse ignore your UIView (Beta Feature)
```
UIView* viewToIgnore;
viewToIgnore.tag = 199;

// Eclipse automatically ignores all views tagged "199"

```
