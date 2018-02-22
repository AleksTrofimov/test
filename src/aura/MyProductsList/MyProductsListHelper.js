({
	initCmp: function(component) {
        console.log("MyProductList init");
        var product = {
            id: "",
            name: "",
            cost: 0,
            stock: 0
            
        };
        component.set("v.product", product);
        
        this.getProducts(component);
	},
   
    getProducts: function(component) {
        console.log("getProducts");
		var action = component.get("c.getProducts");
        action.setCallback(this, function(data) {
            var state = data.getState();
            var response = JSON.parse(data.getReturnValue());
            console.log(state);
            console.log(response);
    		component.set("v.products", response);
		}); 
		$A.enqueueAction(action);
    },
    
	createProduct: function(component) {
        console.log("createProduct");
		var product = component.get("v.product");
        console.log(product);
		var action = component.get("c.createProduct");
        action.setParams({
            product: product
        });
		action.setCallback(this, function(data) {
            var state = data.getState();
            console.log(state);
			if (state === "SUCCESS") {
                console.log(data.getReturnValue());
                var response = JSON.parse(data.getReturnValue());
                console.log(response);
                component.set("v.product", undefined);
                component.set("v.showProductForm", false);
				this.getProducts(component);
            } else if (state === "INCOMPLETE") {
                console.log("Some errors");
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }   		
		}); 
		$A.enqueueAction(action);
    },

	deleteProduct: function(component, event) {
        console.log("deleteProduct");
        var productId = event.target.id;
		var action = component.get("c.deleteProduct");
        action.setParams({
            id: productId
        });       
        action.setCallback(this, function(data) {
            var state = data.getState();
            console.log(state);
			if (state === "SUCCESS") {
                var response = JSON.parse(data.getReturnValue());
                console.log(response);
				this.getProducts(component);
            } else if (state === "INCOMPLETE") {
                console.log("Some errors");
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }   		
		}); 
        console.log("end");
		$A.enqueueAction(action);
    },
    
	updateProduct: function(component) {
        console.log("UpdateProduct");
        var product = component.get("v.product");
        console.log(product);
        var action = component.get("c.updateProduct");
        action.setParams({
            product: product
        });
		action.setCallback(this, function(data) {
            var state = data.getState();
            var response = JSON.parse(data.getReturnValue());
            console.log(response);
            console.log(state);
			if (state === "SUCCESS") {
                component.set("v.product", undefined);
                component.set("v.showProductForm", false);
				this.getProducts(component);
            } else if (state === "INCOMPLETE") {
                console.log("Some errors");
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }   		
		}); 
		$A.enqueueAction(action);
    },
    
    getProduct: function(component, event) {
        console.log("getProduct");
        var productId = event.target.id;
        console.log(productId);

        var action = component.get("c.getProduct");
        action.setParams({
            id: productId
        });
		action.setCallback(this, function(data) {
            var state = data.getState();
            console.log(state);
			if (state === "SUCCESS") {
                var response = JSON.parse(data.getReturnValue());
                console.log(response);
                
                component.set("v.showProductForm", true);
                component.set("v.product", response);
            } else if (state === "INCOMPLETE") {
                console.log("Some errors");
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }   		
		});
		$A.enqueueAction(action);
    },
    
    saveOrCreateProduct: function(component) {
        var product = component.get("v.product");
        if($A.util.isEmpty(product.id)){
            this.createProduct(component);
        } else {
            this.updateProduct(component);
        }
    },
    
    openNewForm: function(component) {
        component.set("v.showProductForm", true);
    },
    
    closeForm: function(component) {
        component.set("v.product", undefined);
		component.set("v.showProductForm", false);
    }

})