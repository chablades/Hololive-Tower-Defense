using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(RoadCreator))]
public class RoadEditor : Editor
{
    RoadCreator creator;

    void OnSceneGUI()
    {

        if (creator.autoUpdate && Event.current.type == EventType.Repaint)
        {
            creator.UpdateRoad();
        }
    }

    void OnEnable()
    {
        creator = (RoadCreator)target;
    }
}
