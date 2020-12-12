using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class UVListener : MonoBehaviour
{
    public MeshRenderer mr;
    public Material mat;
    public bool isMoving = true;

    [ExecuteInEditMode]
    private void Update()
    {
        if (isMoving == false) return;
        float xdamp = mat.GetFloat("_uvx");
        float ydamp = mat.GetFloat("_uvy");
        Vector3 myPos = new Vector3(xdamp * 2, ydamp * 2, 0);
        transform.localPosition = myPos;
    }
}
