using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Pulse : MonoBehaviour
{
    [SerializeField] private float pulseMaxRadius = 10.0f;
    [SerializeField] private float pulseSpeed = 2.0f;
    [SerializeField] private Color pulseColor = Color.white;
    [SerializeField] private float pulseSize = 1.0f;

    private Vector3 pulseStartingPos = Vector3.zero;
    private float pulseRadius = 0.0f;
    private bool isPulsing = false;

    void Start()
    {
        pulseRadius = 0.0f;
        pulseStartingPos = Vector3.zero;
    }

    void Update()
    {
        if (isPulsing)
        {
            pulseRadius += pulseSpeed * Time.deltaTime;

            if (pulseRadius > pulseMaxRadius)
            {
                isPulsing = false;
            }

            foreach (Renderer renderer in FindObjectsOfType<Renderer>()) 
            {
                Material mat = renderer.material;
                mat.SetVector("pulseStartingPosition", pulseStartingPos);
                mat.SetFloat("pulseRadius", pulseRadius);
                mat.SetFloat("pulseSize", pulseSize);
                mat.SetColor("pulseColor", pulseColor);
                mat.SetInt("isPulsing", isPulsing ? 1 : 0);
            }
        }

        if (Input.GetKeyDown(KeyCode.Mouse0))
        {
            StartPulse();
        }
    }


    public void StartPulse()
    {
        isPulsing = true;
        pulseStartingPos = transform.position;
        pulseRadius = 0.0f;
    }
}
