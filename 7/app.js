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

// Register service worker
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('service-worker.js')
    .then(() => console.log('✅ Service Worker Registered'))
    .catch(err => console.error('❌ Service Worker Failed:', err));
}
let deferredPrompt;

window.addEventListener('beforeinstallprompt', (e) => {
  e.preventDefault();
  deferredPrompt = e;

  // Optionally show a custom install button
  const installBtn = document.createElement("button");
  installBtn.textContent = "Install ShopEasy App";
  installBtn.style.position = "fixed";
  installBtn.style.bottom = "1rem";
  installBtn.style.right = "1rem";
  installBtn.style.padding = "0.5rem 1rem";
  installBtn.style.background = "#4CAF50";
  installBtn.style.color = "#fff";
  installBtn.style.border = "none";
  installBtn.style.borderRadius = "8px";
  installBtn.style.cursor = "pointer";
  document.body.appendChild(installBtn);

  installBtn.addEventListener('click', () => {
    installBtn.remove();
    deferredPrompt.prompt();
    deferredPrompt.userChoice.then(choiceResult => {
      if (choiceResult.outcome === 'accepted') {
        console.log('✅ User accepted install');
      } else {
        console.log('❌ User dismissed install');
      }
      deferredPrompt = null;
    });
  });
});