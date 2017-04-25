import Vector from '../src/vector';

describe('Vector', () => {
  it('should be equal', () => {
    const c1 = new Vector(2, 3);
    const c2 = new Vector(2, 3);
    expect(c1).toEqual(c2);
  });

  it('should not be equal because of 1st coordinate', () => {
    const c1 = new Vector(2, 3);
    const c2 = new Vector(3, 3);
    expect(c1).not.toEqual(c2);
  });

  it('should not be equal because of 2st coordinate', () => {
    const c1 = new Vector(2, 3);
    const c2 = new Vector(2, 4);
    expect(c1).not.toEqual(c2);
  });

  it('should have an origin', () => {
    const c1 = new Vector(0, 0);
    expect(Vector.origin).toEqual(c1);
  });

  it('should have addition', () => {
    const c1 = new Vector(1, 2);
    const c2 = new Vector(3, 4);
    expect(c1.plus(c2)).toEqual(new Vector(1 + 3, 2 + 4));
  });
});
