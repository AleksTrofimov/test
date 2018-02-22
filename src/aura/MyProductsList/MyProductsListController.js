({
    handleInitCmp: function(component, event, helper) {
        helper.initCmp(component);
    },

    handleGetProducts: function(component, event, helper) {
        helper.getProducts(component);
    },
    
    handleGetProduct: function(component, event, helper) {
        helper.getProduct(component, event);
    },
        
    handleCreateProduct: function(component, event, helper) {
        helper.createProduct(component);
    },
    
	handleUpdateProduct: function(component, event, helper) {
        helper.updateProduct(component, event);
    },
    
    handleDeleteProduct: function(component, event, helper) {
        helper.deleteProduct(component, event);
    },
    
    handleOpenNewForm: function(component, event, helper) {
        helper.openNewForm(component);
    },
    
    handleCloseForm: function(component, event, helper) {
        helper.closeForm(component);
    },
    
    handleSaveOrCreateProduct: function(component, event, helper) {
        helper.saveOrCreateProduct(component);
    }

})