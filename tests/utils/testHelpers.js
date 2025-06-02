function expectObjectToHaveProperties(obj, properties) {
  properties.forEach(prop => {
    expect(obj).toHaveProperty(prop);
  });
}
module.exports = {
  expectObjectToHaveProperties
}