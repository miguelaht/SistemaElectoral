/**
 * Creates a new marker and adds it to a group
 * @param {H.map.Group} group       The group holding the new marker
 * @param {H.geo.Point} coordinate  The location of the marker
 * @param {String} html             Data associated with the marker
 */
function addMarkerToGroup(group, coordinate, html) {
    const marker = new H.map.Marker(coordinate);
    // add custom data to the marker
    marker.setData(html);
    group.addObject(marker);
}

/**
 * Add two markers showing the position of Liverpool and Manchester City football clubs.
 * Clicking on a marker opens an infobubble which holds HTML content related to the marker.
 * @param  {H.Map} map      A HERE Map instance within the application
 */
function addInfoBubble(map, id, estado, depto, muni, lat, lng, desc, votantes) {
    const group = new H.map.Group();
    map.addObject(group);
    // add 'tap' event listener, that opens info bubble, to the group
    group.addEventListener('tap', function (evt) {
        // event target is the marker itself, group is a parent event target
        // for all objects that it contains
        const bubble = new H.ui.InfoBubble(evt.target.getGeometry(), {
            // read custom data
            content: evt.target.getData()
        });
        // show info bubble
        ui.addBubble(bubble);
    }, false);
    str = '<div><b>ID</b> ' + id + '</div>';
    str += '<div><b>Estado</b> ' + estado == 1 ? 'Abierta' : 'Cerrada' + '</div>';
    str += '<div><b>Departamento</b> ' + depto + '</div>';
    str += '<div><b>Municipio</b> ' + muni + '</div>';
    str += '<div><b>Votantes</b> ' + votantes + '</div>';
    addMarkerToGroup(group, {lat, lng}, str);
}

/**
 * An event listener is added to listen to tap events on the map.
 * Clicking on the map displays an alert box containing the latitude and longitude
 * of the location pressed.
 * @param  {H.Map} map      A HERE Map instance within the application
 */
function setUpClickListener(map) {
// Attach an event listener to map display
// obtain the coordinates and display in an alert box.
    map.addEventListener('tap', function (evt) {
        const coord = map.screenToGeo(evt.currentPointer.viewportX,
                evt.currentPointer.viewportY);
        logEvent(
                Math.abs(coord.lat.toFixed(4)),
                Math.abs(coord.lng.toFixed(4)));
        //Math.abs(coord.lat.toFixed(4)) + ((coord.lat > 0) ? 'N' : 'S'),
        //Math.abs(coord.lng.toFixed(4)) + ((coord.lng > 0) ? 'E' : 'W'));
    });
}


// Helper for logging events
function logEvent(lat, lng) {
    document.getElementById("lat").value = lat;
    document.getElementById("lng").value = lng;
}

/**
 * Boilerplate map initialization code starts below:
 */

// initialize communication with the platform
// In your own code, replace variable window.apikey with your own apikey
const platform = new H.service.Platform({
    apikey: 'TKCxKDWABN53GlLfc5VKPXsCaiDm2E02qQTqD8l1pBI'
});
const defaultLayers = platform.createDefaultLayers();
// initialize a map - this map is centered over Europe
const map = new H.Map(document.getElementById('map'),
        defaultLayers.vector.normal.map, {
            center: {lat: 14.8689, lng: -86.93},
            zoom: 7,
            pixelRatio: window.devicePixelRatio || 1
        });
// add a resize listener to make sure that the map occupies the whole container
window.addEventListener('resize', () => map.getViewPort().resize());
// MapEvents enables the event system
// Behavior implements default interactions for pan/zoom (also on mobile touch environments)
const behavior = new H.mapevents.Behavior(new H.mapevents.MapEvents(map));
// create default UI with layers provided by the platform
const ui = H.ui.UI.createDefault(map, defaultLayers);


// get coordinate
//setUpClickListener(map);

// Now use the map as required...
//addInfoBubble(map, 84.01, -76.1);
