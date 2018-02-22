@isTest
private class ProductsCtrlTest {

    @isTest
    static void testCreateProduct() {
        
        Map<String, String> map1 = new Map<String, String>();
            map1.put('name', 'test');
            map1.put('cost', '10');
			map1.put('stock', '5');
        ProductsCtrl.createProduct(map1);
        List<Products__c> products = [SELECT Id, Name, Cost__c, Stock__c FROM Products__c WHERE Name = 'test' AND Cost__c = 10];
        Products__c product = products.get(0);
        
        System.debug('We added new prod' + product.Name);
        System.assertEquals(10, product.Cost__c);

    }
    
    @isTest
    static void testDeleteProduct() {

        String productId;

        Products__c prod = new Products__c(Name = 'testProd', Cost__c = 1, Stock__c = 1);
        insert prod;
        List<Products__c> products = [
            SELECT Id, Name, Cost__c, Stock__c 
            FROM Products__c 
            WHERE Name = 'testProd' AND Cost__c = 1 AND Stock__c = 1];
        Products__c product = products.get(0);
        productId = product.Id;
        System.debug('We added new product with Id = ' + productId);
        ProductsCtrl.deleteProduct(productId);
        //System.debug('Product was deleted');
        //System.assertEquals(productId, deletedProductId);

        /*Products__c newtestprod = new Products__c(Id = '123', Name='first', Cost__c=100);
        insert newtestprod;
        newtestprod = [SELECT Cost__c FROM Products__c WHERE Id =:newtestprod.Id];
        System.assertEquals(100, newtestprod.Cost__c, 'product was deleted');*/

    }

    @isTest
    static void testUpdateProduct() {
        
        String productIdBefore;
        String productIdAfter;

        Products__c prod = new Products__c(Name = 'testProd', Cost__c = 2, Stock__c = 2);
        insert prod;

        List<Products__c> product1 = [
            SELECT Id, Name, Cost__c, Stock__c
            FROM Products__c 
            WHERE Name = 'testProd' AND Cost__c = 2 AND Stock__c = 2];
        Products__c prod1 = product1.get(0);
        productIdBefore = prod1.Id;

        Map<String, String> map1 = new Map<String, String>();
            map1.put('id', productIdBefore);
            map1.put('name', 'test');
            map1.put('cost', '10');
			map1.put('stock', '5');
        ProductsCtrl.updateProduct(map1);

        List<Products__c> product2 = [
            SELECT Id, Name, Cost__c, Stock__c
            FROM Products__c 
            WHERE Name = 'test' AND Cost__c = 10 AND Stock__c = 5];
        Products__c prod2 = product2.get(0);
        productIdAfter = prod2.Id;

        System.debug(productIdBefore);
        System.debug(productIdAfter);
        System.assertEquals(productIdBefore, productIdAfter);
        //передавать мапу на апдейт
        
    }

    @isTest
    static void testGetProduct() {

        String productId;
        String getProd;

        Products__c prod = new Products__c(Name = 'testGetProd', Cost__c = 1, Stock__c = 1);
        insert prod;
        List<Products__c> product = [
            SELECT Id
            FROM Products__c 
            WHERE Name = 'testGetProd' AND Cost__c = 1 AND Stock__c = 1];
        Products__c prod1 = product.get(0);
        productId = prod1.Id;
        getProd = ProductsCtrl.getProduct(productId);
        System.equals(prod, getProd);

    }

    @isTest
    static void testGetProducts() {

        Boolean rezult;

        Products__c p1= new Products__c(Name = 'testProd1', Cost__c = 1, Stock__c = 1);
        insert p1;
        Products__c p2 = new Products__c(Name = 'testProd2', Cost__c = 2, Stock__c = 2);
        insert p2;

        List<Products__c> testProd = (List<Products__c>)JSON.deserializeStrict(ProductsCtrl.getProducts(), List<Products__c>.class);
        Products__c prod1 = testProd.get(0);
        Products__c prod2 = testProd.get(1);
        System.equals(prod1.Name, prod2.Name);
        System.equals(prod1.Cost__c, prod2.Cost__c);

    }

    @isTest
    static void testGetLimitProducts() {
        
        Integer numberOfProducts;
        Boolean rezult;

        Products__c p1= new Products__c(Name = 'testProd1', Cost__c = 1, Stock__c = 1);
        insert p1;
        Products__c p2 = new Products__c(Name = 'testProd2', Cost__c = 2, Stock__c = 2);
        insert p2;
        Products__c p3 = new Products__c(Name = 'testProd3', Cost__c = 3, Stock__c = 3);
        insert p3;
        Products__c p4 = new Products__c(Name = 'testProd4', Cost__c = 4, Stock__c = 4);
        insert p4;

        List<Products__c> allProducts = (List<Products__c>)JSON.deserializeStrict(ProductsCtrl.getLimitProducts(4), List<Products__c>.class);
        numberOfProducts = allProducts.size();
        
        System.assertEquals(numberOfProducts, 4);

    }

}