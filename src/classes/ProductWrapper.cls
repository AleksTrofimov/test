public with sharing class ProductWrapper {
    public String id;
    public String name;
    public Decimal cost;
    public Decimal stock;
    
    public ProductWrapper() {
        
    }
    
    public ProductWrapper(Products__c prod) {
        id = prod.Id;
        name = prod.Name;
        cost = prod.Cost__c;
        stock = prod.Stock__c;
    }
}