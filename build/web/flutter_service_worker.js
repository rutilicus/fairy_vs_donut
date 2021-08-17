'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "16f3250c25b8253c09e9ebe81e4c870f",
"assets/assets/base.edg": "84582844bd4526249f6eb86d4f33cb41",
"assets/assets/base.png": "85dc366949dad1359b626120d094c237",
"assets/assets/donut.edg": "148a72946559f924ee269180d37c107f",
"assets/assets/donut.png": "e9496cf7ca14c6f52ddd06a5ea7bafaa",
"assets/assets/fairy.edg": "6238f298079264f88790cde95719099a",
"assets/assets/fairy.png": "56a52f0b330d1cee13cbdcb71d1c9b96",
"assets/assets/logo.edg": "0360d08b24301f49924516d27e6b4950",
"assets/assets/logo.png": "9d2d51fb6d91f5071ed08863b6eacec9",
"assets/assets/notice.edg": "9c1c5aabbdffaceee415a061bd88460f",
"assets/assets/notice.png": "2d4801b20b46136d95458dbe3b2beb73",
"assets/assets/num.edg": "6418db62b5894bc4312387a517f13215",
"assets/assets/num_donut_0.png": "61a09caa62710773b62d04ebdb705be0",
"assets/assets/num_donut_1.png": "efc202df66638612b9656ef7baea23ae",
"assets/assets/num_donut_2.png": "dae58a5c13d51c50cd29b374f7e2af08",
"assets/assets/num_donut_3.png": "e4079d9a229bbc3424f09ee6067db1c8",
"assets/assets/num_donut_4.png": "775c713787e213265891817ef95d5e0e",
"assets/assets/num_donut_5.png": "71dff6f82fe407f6bb7866c688f13134",
"assets/assets/num_donut_6.png": "7789eacfdf363e465b98e86205d627b5",
"assets/assets/num_donut_7.png": "88fce47a22fcb573fc2924b8664ad6ac",
"assets/assets/num_donut_8.png": "635d35132f11011d8b5a8ebfe22444d8",
"assets/assets/num_donut_9.png": "c19221167873721fdf1d706b325911ad",
"assets/assets/num_fairy_0.png": "4ec6e3157e28b91ba103e8f75776fa1f",
"assets/assets/num_fairy_1.png": "b37d454130cb40e77fa143d321c9d34a",
"assets/assets/num_fairy_2.png": "237326b21021885908ffb0dffec79fc9",
"assets/assets/num_fairy_3.png": "0cdcbb70c6f1b2c488985f4ac8f08644",
"assets/assets/num_fairy_4.png": "607d6cebd329021556b675d12de59fae",
"assets/assets/num_fairy_5.png": "2282d2a8db9012d0bd8f92b87184fdaf",
"assets/assets/num_fairy_6.png": "5742e387039da33fb249e8b3812c8701",
"assets/assets/num_fairy_7.png": "34b8292a5e80956f301fa7b4e893bf82",
"assets/assets/num_fairy_8.png": "02cc56a54aec67c9f4e90eaa00f04ff1",
"assets/assets/num_fairy_9.png": "bb93d273dd973999012fb4075ef3f2c7",
"assets/assets/over.edg": "6e229f5e51b261d73bc9a6bb0b1c82d9",
"assets/assets/over.png": "71dd647b4769d3ceb00720db877f0a4e",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "a343d01e8cc8e460d0526fb92f70b5f9",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"favicon.png": "ad5ab50f86d2a1c3a8a09a128ef1474a",
"icons/Icon-192.png": "4aa21fad59dcb96a64215c0197af0f91",
"icons/Icon-512.png": "72594e5c112aad78450f7d6eea5ae432",
"index.html": "cf199f23bfb73388c674e826044a3553",
"/": "cf199f23bfb73388c674e826044a3553",
"main.dart.js": "e2aebfa12897f6e784000f3c96ab3d3e",
"manifest.json": "8f2001aadb457edeab4e04f389db131e",
"version.json": "7b7b1a8ccdd18fb4186b06f29acd7bb8"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
