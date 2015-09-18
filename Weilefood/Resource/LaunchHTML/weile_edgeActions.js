
(function($,Edge,compId){var Composition=Edge.Composition,Symbol=Edge.Symbol;
//Edge symbol: 'stage'
(function(symbolName){Symbol.bindSymbolAction(compId,symbolName,"beforeDeletion",function(sym,e){});
//Edge binding end
Symbol.bindElementAction(compId,symbolName,"window","resize",function(sym,e){});
//Edge binding end
})("stage");
//Edge symbol end:'stage'
})(jQuery,AdobeEdge,"EDGE-16349150");