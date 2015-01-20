
Crafty.c("Polygon",{
    _points:[],
    __ctx:null,
    _can:null,
    init:function(){
        this._ctx = Crafty.canvas.context;
        this._can = Crafty.canvas._canvas;
        
        this.bind("EnterFrame",function(){
        this.draw();
        })
    },
    draw:function(){
     this._can.width = this._can.width;
     this._ctx.beginPath();
        for(var i in this._points){
        var p = this._points[i];
           
            this._ctx.lineTo(Crafty.viewport.x+p[0], Crafty.viewport.y+p[1]);
        }
        this._ctx.closePath();
        this._ctx.stroke();
    }
});