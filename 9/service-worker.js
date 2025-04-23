const CACHE_NAME = "shop-cache-v3";
const urlsToCache = [
  "index.html",
  "styles.css",
  "app.js",
  "manifest.json",
  '/icons/icon-192x192.png',
  '/icons/icon-512x512.png'
];

// Install
self.addEventListener("install", (e) => {
  console.log("[SW] Installing...");
  e.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      console.log("[SW] Caching assets...");
      return cache.addAll(urlsToCache);
    })
  );
});

// Activate
self.addEventListener("activate", (e) => {
  console.log("[SW] Activated");
  e.waitUntil(
    caches.keys().then(keys =>
      Promise.all(
        keys.map(key => {
          if (key !== CACHE_NAME) {
            console.log("[SW] Removing old cache:", key);
            return caches.delete(key);
          }
        })
      )
    )
  );
});

// Fetch
self.addEventListener("fetch", (e) => {
  e.respondWith(
    caches.match(e.request)
      .then(response => response || fetch(e.request))
      .catch(() => new Response("Offline fallback content", { status: 503 }))
  );
});

// Sync
self.addEventListener("sync", (e) => {
  if (e.tag === "sync-cart") {
    console.log("🔄 [SW] Background sync triggered: syncing cart...");
    e.waitUntil(
      new Promise((res) => {
        setTimeout(() => {
          console.log("✅ [SW] Cart synced to server!");
          res();
        }, 3000);
      })
    );
  }
});

// Push (Simulated)
self.addEventListener("push", (e) => {
  const data = e.data?.text() || "📢 You have a new offer!";
  console.log("📲 [SW] Push Received:", data);
  self.registration.showNotification("ShopEasy", {
    body: data,
    icon: "icons/icon-192x192.png"
  });
});

// Message to simulate push
self.addEventListener("message", (e) => {
  if (e.data.action === "simulate-push") {
    self.dispatchEvent(new PushEvent("push", {
      data: new Blob(["🔥 Flash Sale on Electronics!"])
    }));
  }
});
