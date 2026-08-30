using UnityEngine;

public class PathCreator : MonoBehaviour
{
    [HideInInspector] public Path path;

    public Color anchorColor = Color.red;
    public Color controlColor = Color.white;
    public Color segmentColor = Color.green;
    public Color selectedSegmentColor = Color.yellow;
    public float anchorDiameter = .1f;
    public float controlDiameter = .075f;
    public bool displayControlPoints = true;

    Vector2[] cachedEvenlySpacedPoints;
    float cachedSpacing = -1;
    float cachedResolution = -1;
    bool cachedIsClosed;

    public void CreatePath()
    {
        path = new Path(transform.position);
    }

    void Reset()
    {
        CreatePath();
    }

    public Vector2[] GetEvenlySpacedPoints(float spacing, float resolution = 1)
    {
        bool cacheInvalid = cachedEvenlySpacedPoints == null
            || cachedSpacing != spacing
            || cachedResolution != resolution
            || cachedIsClosed != path.IsClosed;

        if (cacheInvalid)
        {
            cachedEvenlySpacedPoints = path.CalculateEvenlySpacedPoints(spacing, resolution);
            cachedSpacing = spacing;
            cachedResolution = resolution;
            cachedIsClosed = path.IsClosed;
        }

        return cachedEvenlySpacedPoints;
    }
    
}
