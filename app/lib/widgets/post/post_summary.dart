import 'package:flutter/material.dart';
import 'package:thud/models/post.dart';
import 'package:thud/models/thudstate.dart';

import 'package:thud/widgets/post/create_post.dart';
import 'package:thud/widgets/post/post_details.dart';
import 'package:thud/widgets/post/post_widgets.dart';
import 'package:thud/langs/localizations.dart';




class PostSummary extends StatelessWidget {
  final PostProvider post;
  const PostSummary(this.post, {super.key});
  @override build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<PostProvider>.value(
            value: post,
            child: Consumer<PostProvider>(
              builder: (_, post, __) => PostDetailScreen(post),
            ),
          ),
        )),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [PostWidgets(post, true)],
          ),
        ),
      ),
    );
  }
}

class PostSummaryList extends StatelessWidget {
  final List<PostProvider> posts;
  const PostSummaryList(this.posts, {super.key});
  @override build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => ChangeNotifierProvider<PostProvider>.value(
          value: posts[index],
          child: Consumer<PostProvider>(
            builder: (_, postProvider, __) => PostSummary(postProvider),
          ),
        ),
        childCount: posts.length,
      ),
    );
  }
}



class PostSummaryListScreen extends StatefulWidget {
  const PostSummaryListScreen({super.key});
  @override createState() => _PostSummaryListScreen();
}

class _PostSummaryListScreen extends State<PostSummaryListScreen> {


  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
      _refreshIndicatorKey.currentState?.show()
    );
  }

  List<PostProvider> _posts = [];

  var _query = SearchContentRequest();
  final _keywordController = TextEditingController();


  Future<void> _searchDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(tr(context, 'search')),
            actions: [
              TextButton(
                child: Text(tr(context, 'reset')),
                onPressed: () {
                  _keywordController.clear();
                  setState(() => _query = SearchContentRequest());
                },
              ),
              TextButton(
                child: Text(tr(context, 'done')),
                onPressed: () {
                  Navigator.of(context).pop();
                  _refreshIndicatorKey.currentState?.show();
                },
              ),
            ],
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:[
                  TextField(
                    controller: _keywordController,
                    onChanged: (value) => setState(() => _query.keywords = value),
                    decoration: InputDecoration(labelText: tr(context, 'keywords')),
                  ),
                  const SizedBox(height: 8),
                  Text(tr(context, 'searchIn')),
                  CheckboxListTile(
                    dense: true,
                    value: _query.searchContent,
                    onChanged: (value) => setState(() => _query.searchContent = value!),
                    title: Text(tr(context, 'content')),
                  ),
                  CheckboxListTile(
                    dense: true,
                    value: _query.searchTitle,
                    onChanged: (value) => setState(() => _query.searchTitle = value!),
                    title: Text(tr(context, 'title')),
                  ),
                  CheckboxListTile(
                    dense: true,
                    value: _query.searchTags,
                    onChanged: (value) => setState(() => _query.searchTags = value!),
                    title: Text(tr(context, 'tags')),
                  ),
                  CheckboxListTile(
                    dense: true,
                    value: _query.searchUsername,
                    onChanged: (value) => setState(() => _query.searchUsername = value!),
                    title: Text(tr(context, 'username')),
                  ),
                  CheckboxListTile(
                    dense: true,
                    value: _query.searchComments,
                    onChanged: (value) => setState(() => _query.searchComments = value!),
                    title: Text(tr(context, 'comments')),
                  ),
                    
            
                  const Divider(),
                  CheckboxListTile(
                    value: _query.followedOnly,
                    dense: true,
                    onChanged: (value) => setState(() => _query.followedOnly = value!),
                    title: Text(tr(context, 'followOnly')),
                  ),
                  const Divider(),
                  Text(tr(context, 'sortMethod')),
                  RadioListTile(
                    value: 'new',
                    groupValue: _query.sortMethod,
                    onChanged: (value) => setState(() => _query.sortMethod = value!),
                    title: Text(tr(context, 'new')),
                    dense: true,
                  ),
                  RadioListTile(
                    value: 'best',
                    groupValue: _query.sortMethod,
                    onChanged: (value) => setState(() => _query.sortMethod = value!),
                    title: Text(tr(context, 'best')),
                    dense: true,
                  ),
                  RadioListTile(
                    value: 'hot',
                    groupValue: _query.sortMethod,
                    onChanged: (value) => setState(() => _query.sortMethod = value!),
                    title: Text(tr(context, 'hot')),
                    dense: true,
                  ),
                  RadioListTile(
                    value: 'comments',
                    groupValue: _query.sortMethod,
                    onChanged: (value) => setState(() => _query.sortMethod = value!),
                    title: Text(tr(context, 'comments')),
                    dense: true,
                  ),
            
                ],
              ),
            ),
          );
        }
      ),
    );
  }


  @override build(BuildContext context) {
    var thudState = context.read<ThudState>();
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          var posts = await thudState.searchPosts(_query);
          setState(() => _posts = posts);
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: true,
              title: Text(tr(context, 'posts')),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async => await _searchDialog(context),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CreatePostScreen())
                  ).then((value) {
                    if (value == true) {
                      _refreshIndicatorKey.currentState?.show();
                    }
                  }),
                ),
              ],
            ),
            PostSummaryList(_posts),
          ],
        ),
      ),
    );
  }
}