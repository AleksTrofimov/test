
public class ProductsCtrl {
    
    @AuraEnabled
    public static String createProduct(Map<String, String> product) {
    	String productId = '';
        
        if (product!= null) {
            Products__c newProduct = new Products__c(
                Name = product.get('name'),
                Cost__c = Decimal.valueOf(product.get('cost')),
                Stock__c = Decimal.valueOf(product.get('stock'))
            );
            insert newProduct;

            productId = newProduct.Id;
        } 

		return JSON.serializePretty(productId);
    }

	@AuraEnabled
    public static String deleteProduct(String id) {
		String productId = '';

        if (String.isNotBlank(id)) {
            List<Products__c> oneProduct = [SELECT Id, Name, Cost__c, Stock__c FROM Products__c WHERE Id = :id];
				Products__c product = oneProduct.get(0);
                delete product;                
        }

        return JSON.serializePretty(productId); 
   }

    
	@AuraEnabled
	public static String updateProduct(Map<String, String> product) {
        String productId = ''; 
        
        if (product != null) {
            List<Products__c> products = [SELECT Id, Name, Cost__c FROM Products__c WHERE Id = :product.get('id')];
            if (!products.isEmpty()) {
                Products__c updatedProduct = products.get(0);
                updatedProduct.Id = product.get('id');
                updatedProduct.Name = product.get('name');
                updatedProduct.Cost__c = Decimal.valueOf(product.get('cost'));
                updatedProduct.Stock__c = Decimal.valueOf(product.get('stock'));
                update updatedProduct;
    
                productId = updatedProduct.Id;
            }
        }

        return JSON.serializePretty(productId);
   }
    
	@AuraEnabled
	public static String getProduct(String id) {
        ProductWrapper productWrapper = new ProductWrapper();

		if (String.isNotBlank(id)) {
            List<Products__c> products = [SELECT Id, Name, Cost__c, Stock__c FROM Products__c WHERE Id = :id];
            if (!products.isEmpty()) {
                Products__c product = products.get(0);
                productWrapper.id = product.Id;
                productWrapper.name = product.Name;
                productWrapper.cost = product.Cost__c;
                productWrapper.stock = product.Stock__c;
            }
		}

      	return JSON.serializePretty(productWrapper);
   }

	@AuraEnabled    
	public static String getProducts() {

    	return JSON.serializePretty([SELECT Id, Name, Cost__c, Stock__c FROM Products__c]);
   }
 
	@AuraEnabled
	public static String getLimitProducts(Integer lim){
        
        return JSON.serializePretty([SELECT Id, Name, Cost__c, Stock__c FROM Products__c LIMIT : lim]);
   } 

       
}