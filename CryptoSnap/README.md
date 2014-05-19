CryptoSnap for iOS
======================

An attempt to create a full end-to-end encrypted SnapChat.

###Motivation

This project attempts to use Keybase as a key distribution center and use the key pairs stored to encrypt/decrypt photos stored on Parse.

The photos are stored on Parse as PFObjects which have a photo attribute which is base 64 encoded.

###Important Notes

This app connects to KeyBase and successfully logs in and retrieves a private user object

This project fails in encrypting and decrypting any photos due to the private keys on Keybase being stored in P3SKB Format. I could not for the life of me get the message unpacked using the Msgpack Objective-C wrapper.

As such, this app connects to parse, retrieves and sends UNENCRYPTED images to its appropriate recipient.

###Usage

Modify CSAPIConstants.m with your Parse credentials as such

```objc
NSString *const kParseAppId = @"CHANGE ME";
NSString *const kParseAppSecret = @"CHANGE ME";
```

### Features
* Sends a image from one user to another. UNENCRYPTED
* Lets user's retrieve images sent to them.

### License
This project is released under the MIT License.