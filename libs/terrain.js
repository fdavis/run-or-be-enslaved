// taken from http://www.somethinghitme.com/2013/11/11/simple-2d-terrain-with-midpoint-displacement/
function terrain(width, height, displace, roughness){
    var points = [],
        // Gives us a power of 2 based on our width
        power = Math.pow(2, Math.ceil(Math.log(width) / (Math.log(2))));
     
    // Set the initial left point
    points[0] = height/2 + (Math.random()*displace*2) - displace;
    // set the initial right point
    points[power] = height/2 + (Math.random()*displace*2) - displace;
    displace *= roughness;
     
    // Increase the number of segments
    for(var i = 1; i < power; i *=2){
        // Iterate through each segment calculating the center point
        for(var j = (power/i)/2; j < power; j+= power/i){
            points[j] = ((points[j - (power / i) / 2] + points[j + (power / i) / 2]) / 2);
            points[j] += (Math.random()*displace*2) - displace
        }
        // reduce our random range
        displace *= roughness;
    }    
    return points;
}