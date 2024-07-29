import Amplify, { Auth, API } from 'aws-amplify';
import awsconfig from './aws-exports';
Amplify.configure(awsconfig);

const signUp = async () => {
    const email = document.getElementById('sign-up-email').value;
    const password = document.getElementById('sign-up-password').value;
    
    try {
        const { user } = await Auth.signUp({
            username: email,
            password,
        });
        console.log('Sign up successful', user);
    } catch (error) {
        console.error('Error signing up:', error);
    }
};

const signIn = async () => {
    const email = document.getElementById('sign-in-email').value;
    const password = document.getElementById('sign-in-password').value;
    
    try {
        const user = await Auth.signIn(email, password);
        console.log('Sign in successful', user);
        loadProducts();
    } catch (error) {
        console.error('Error signing in:', error);
    }
};

const signOut = async () => {
    try {
        await Auth.signOut();
        console.log('Sign out successful');
    } catch (error) {
        console.error('Error signing out:', error);
    }
};

const resetPassword = async () => {
    const email = document.getElementById('reset-password-email').value;

    try {
        await Auth.forgotPassword(email);
        console.log('Password reset email sent');
    } catch (error) {
        console.error('Error resetting password:', error);
    }
};

const loadProducts = async () => {
    try {
        const products = await API.get('reactAppApi', '/products');
        const productList = document.getElementById('product-list');
        productList.innerHTML = '';
        products.forEach(product => {
            const li = document.createElement('li');
            li.textContent = product.name;
            productList.appendChild(li);
        });
    } catch (error) {
        console.error('Error loading products:', error);
    }
};

const addToCart = async (productId) => {
    try {
        await API.post('reactAppApi', '/cart', { body: { productId } });
        console.log('Product added to cart');
    } catch (error) {
        console.error('Error adding product to cart:', error);
    }
};

const loadCart = async () => {
    try {
        const cart = await API.get('reactAppApi', '/cart');
        const cartList = document.getElementById('cart-list');
        cartList.innerHTML = '';
        cart.items.forEach(item => {
            const li = document.createElement('li');
            li.textContent = item.name;
            cartList.appendChild(li);
        });
    } catch (error) {
        console.error('Error loading cart:', error);
    }
};

const checkout = async () => {
    try {
        await API.post('reactAppApi', '/checkout');
        console.log('Checkout successful');
    } catch (error) {
        console.error('Error during checkout:', error);
    }
};
