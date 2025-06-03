function expectObjectToHaveProperties(obj, properties) {
  properties.forEach(prop => {
    expect(obj).toHaveProperty(prop);
  });
}
function expectBaseStructure(obj){
  expectObjectToHaveProperties(obj, ["result", "error_code", "message"]);
}
module.exports = {
  expectObjectToHaveProperties,
  expectBaseStructure
}