import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  @Preview(name: 'Home Page Preview')
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController(
      text:
          "This is some predefined text that can be removed and rewritten. "
          "Select any part of this text to see the magic happen!",
    );

    // State to track if text is selected
    final isTextSelected = useState(false);

    // Listen to selection changes
    useEffect(() {
      void listener() {
        final selection = textController.selection;
        // Show button if selection is not collapsed (i.e., has range)
        isTextSelected.value = !selection.isCollapsed && selection.start != -1;
      }

      textController.addListener(listener);
      return () => textController.removeListener(listener);
    }, [textController]);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Layer 1: Text Field
            Padding(
              padding: EdgeInsets.all(20.w),
              child: TextField(
                controller: textController,
                maxLines: null, // Multiline
                style: TextStyle(fontSize: 18.sp, height: 1.5),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter text here...',
                ),
              ),
            ),

            // Layer 2: Circular Button (Middle Right)
            if (isTextSelected.value)
              Positioned(
                right: 20.w,
                top: 0,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      _showBottomSheet(context);
                    },
                    child: Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: BoxDecoration(
                        color: Colors.blue, // Or theme color
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 30.sp),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => const _OptionsBottomSheet(),
    );
  }
}

class _OptionsBottomSheet extends StatelessWidget {
  const _OptionsBottomSheet();

  @override
  Widget build(BuildContext context) {
    final options = ['Option A', 'Option B', 'Option C', 'Option D'];

    return Container(
      padding: EdgeInsets.all(20.w),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select an Option',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: options.map((option) {
              return ChoiceChip(
                label: Text(option),
                selected: false,
                onSelected: (selected) {
                  if (selected) {
                    Navigator.pop(context); // Close bottom sheet
                    _showToast(context, option);
                  }
                },
              );
            }).toList(),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  void _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected: $message'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        margin: EdgeInsets.all(20.w),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
