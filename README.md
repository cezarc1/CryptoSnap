CryptoSnap for iOS
======================

An attempt to create a full end-to-end encrypted SnapChat. It does this by leveraging [Keybase](https://keybase.io) and [Parse](https://www.parse.com)

###Motivation

This project attempts to use [Keybase](https://keybase.io) as a key distribution center and use the key pairs stored to encrypt/decrypt photos stored on Parse.

The photos are stored on Parse as PFObjects, which have a photo attribute that is base 64 encoded. The base 64 encoded image string would then be potentially encrypted and signed by the user who sent it. Due to the size limitation of 128k on PFObjects the image is compressed.

###Important Notes

This app logs into [Keybase](https://keybase.io/__/api-docs/1.0#call-getsalt) and retrieves a private user object

This project fails in encrypting and decrypting any photos due to the private keys served in the [P3SKB Format](https://keybase.io/__/api-docs/1.0#p3skb-format) by the [Keybase API](https://keybase.io/__/api-docs/1.0#intro). I could not for the life of me get the message unpacked using the [Msgpack Objective-C wrapper](https://github.com/msgpack/msgpack-objectivec).

As such, this app connects to Parse, retrieves and stores the UNENCRYPTED images  on parse for its appropriate recipient.

The UI is incredibly ugly but usable. This application was meant as a proof of concept.

###Usage

Modify CSAPIConstants.m with your Parse credentials as such:

```objc
NSString *const kParseAppId = @"CHANGE ME";
NSString *const kParseAppSecret = @"CHANGE ME";
```

### Features
* Logs into Keybase and retrieves the private user object which should include the private/public key pair.
* Sends a image from one user to another. UNENCRYPTED
* Lets user's retrieve images sent to them.

### License
This project is released under the MIT License.
