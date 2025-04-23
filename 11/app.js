// Service Worker Registration
if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('service-worker.js')
      .then(reg => {
        console.log("✅ Service Worker registered:", reg.scope);

         if ('Notification' in window && Notification.permission !== "granted") {
          Notification.requestPermission().then(permission => {
            if (permission === "granted") {
              console.log("🔔 Notification permission granted.");
            } else {
              console.log("🔕 Notification permission denied.");
            }
          });
        }

        // Background Sync Trigger
        document.getElementById("sync-btn").addEventListener("click", () => {
          if ('SyncManager' in window) {
            reg.sync.register('sync-cart')
              .then(() => {
                console.log("🌀 Sync event registered");
                alert("Cart will sync when you're back online!");
              })
              .catch(err => console.error("Sync registration failed", err));
          } else {
            alert("Background sync not supported");
          }
        });

        // Simulate Push Notification
        document.getElementById("push-btn").addEventListener("click", () => {
          reg.active.postMessage({ action: "simulate-push" });
        });
      })
      .catch(err => console.error("❌ Service Worker registration failed:", err));
  });
}

// Display some sample products
const products = [
  { name: "Smartphone", price: "$299", img: "https://via.placeholder.com/250x150?text=Smartphone" },
  { name: "Headphones", price: "$59", img: "https://via.placeholder.com/250x150?text=Headphones" },
  { name: "Laptop", price: "$999", img: "https://via.placeholder.com/250x150?text=Laptop" }

];

const container = document.getElementById("products");
products.forEach(product => {
  const card = document.createElement("div");
  card.className = "product-card";
  card.innerHTML = `
    <img src="${product.img}" alt="${product.name}">
    <h3>${product.name}</h3>
    <p>${product.price}</p>
    <button>Add to Cart</button>
  `;
  container.appendChild(card);
});
